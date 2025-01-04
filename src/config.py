"""
Application's environment variables configuration.
"""

import os


class DBConfig:
    """Database configuration."""

    DB_DRIVERNAME = os.getenv("DB_DRIVERNAME", ...)
    DB_USERNAME = os.getenv("DB_USERNAME", ...)
    DB_PASSWORD = os.getenv("DB_PASSWORD", ...)
    DB_HOST = os.getenv("DB_HOST", ...)
    DB_PORT: int = int(os.getenv("DB_PORT", ...))
    DB_DATABASE = os.getenv("DB_DATABASE", ...)
    DB_ENABLE_CONNECTION_POOLING: bool = (
        os.getenv("DB_ENABLE_CONNECTION_POOLING", "True") == "True"
    )


class Config:
    """Base configuration."""

    DB_CONFIG: DBConfig = DBConfig()
