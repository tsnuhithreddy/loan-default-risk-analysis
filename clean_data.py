"""
clean_data.py
Cleans the raw FinTrust credit risk dataset and saves the cleaned version.

Usage:
    python clean_data.py
"""

import pandas as pd
import numpy as np


CATEGORICAL_COLS = [
    "person_home_ownership",
    "loan_intent",
    "loan_grade",
    "cb_person_default_on_file",
]


def load_data(path: str) -> pd.DataFrame:
    """Load the raw credit risk CSV."""
    return pd.read_csv(path)


def remove_duplicates(df: pd.DataFrame) -> pd.DataFrame:
    """Drop exact duplicate rows and reset the index."""
    before = len(df)
    df = df.drop_duplicates().reset_index(drop=True)
    print(f"Removed {before - len(df)} duplicate rows")
    return df


def cap_age(df: pd.DataFrame, upper: int = 80) -> pd.DataFrame:
    """Cap person_age at a realistic maximum for a loan applicant."""
    n_outliers = (df["person_age"] > upper).sum()
    df["person_age"] = df["person_age"].clip(upper=upper)
    assert df["person_age"].max() <= upper, "Age cap failed"
    print(f"Capped {n_outliers} age values above {upper}")
    return df


def cap_employment_length(df: pd.DataFrame) -> pd.DataFrame:
    """
    Cap person_emp_length so nobody has more years of employment than is
    possible given their already-capped age, assuming a minimum working
    age of 16.

    Vectorized implementation — no apply/lambda required.
    """
    max_possible = df["person_age"] - 16
    n_invalid = (df["person_emp_length"] > max_possible).sum()
    df["person_emp_length"] = np.minimum(df["person_emp_length"], max_possible)

    valid = df["person_emp_length"].notnull()
    assert (
        df.loc[valid, "person_emp_length"] <= max_possible[valid]
    ).all(), "Employment length cap failed"

    print(f"Capped {n_invalid} impossible employment-length values")
    return df


def flag_and_fill_missing_employment(df: pd.DataFrame) -> pd.DataFrame:
    """
    Flag originally missing employment-length information before
    replacing missing values with 0.

    The flag represents missing employment information, not confirmed
    unemployment.
    """
    df["is_unemployed"] = df["person_emp_length"].isnull().astype(int)
    df["person_emp_length"] = df["person_emp_length"].fillna(0.0)

    assert df["person_emp_length"].isnull().sum() == 0, "Unfilled employment-length nulls remain"
    print(f"Flagged {df['is_unemployed'].sum():,} borrowers with missing employment-length information")
    return df


def impute_interest_rate(df: pd.DataFrame) -> pd.DataFrame:
    """Fill missing loan_int_rate with the median rate for each loan grade."""
    df["loan_int_rate"] = (
        df.groupby("loan_grade")["loan_int_rate"]
        .transform(lambda x: x.fillna(x.median()))
    )
    assert df["loan_int_rate"].isnull().sum() == 0, "Unfilled interest-rate nulls remain"
    return df


def cap_income_outliers(df: pd.DataFrame) -> pd.DataFrame:
    """Cap person_income at the IQR upper fence (Q3 + 1.5*IQR)."""
    q1, q3 = df["person_income"].quantile([0.25, 0.75])
    iqr = q3 - q1
    upper_bound = q3 + 1.5 * iqr

    n_outliers = (df["person_income"] > upper_bound).sum()
    df["person_income"] = df["person_income"].clip(upper=upper_bound)
    assert df["person_income"].max() <= upper_bound, "Income cap failed"
    print(f"Capped {n_outliers} income values above ${upper_bound:,.0f}")
    return df


def standardize_categoricals(df: pd.DataFrame, cols=CATEGORICAL_COLS) -> pd.DataFrame:
    """Strip whitespace and uppercase categorical columns."""
    for col in cols:
        df[col] = df[col].str.strip().str.upper()
    return df


def run_validation(df: pd.DataFrame) -> None:
    """
    Final validation block.
    Fails loudly if any cleaning step produces invalid output.
    """
    assert df.isnull().sum().sum() == 0, "Nulls remain after cleaning"
    assert df["person_age"].between(18, 80).all(), "Age out of expected range"
    assert df["person_emp_length"].min() >= 0, "Negative employment length"
    assert df.duplicated().sum() == 0, "Duplicates remain"
    assert df["is_unemployed"].isin([0, 1]).all(), "Invalid employment-missing flag"
    print("All validation checks passed.")


def clean_pipeline(input_path: str, output_path: str) -> pd.DataFrame:
    df = load_data(input_path)
    df = remove_duplicates(df)
    df = cap_age(df)
    df = cap_employment_length(df)
    df = flag_and_fill_missing_employment(df)
    df = impute_interest_rate(df)
    df = cap_income_outliers(df)
    df = standardize_categoricals(df)
    run_validation(df)
    df.to_csv(output_path, index=False)
    print(f"Saved cleaned dataset to {output_path} ({len(df):,} rows)")
    return df


if __name__ == "__main__":
    clean_pipeline(
        input_path="data/raw/credit_risk_dataset.csv",
        output_path="data/cleaned/credit_risk_cleaned.csv",
    )
