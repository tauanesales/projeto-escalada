from typing import Optional
from sqlalchemy import ForeignKey, Integer, String
from sqlalchemy.orm import Mapped, mapped_column, relationship

from src.database.models.base.entity_model_base import EntityModelBase


class Autor(EntityModelBase):
    __tablename__ = "autores"

    nome: Mapped[str] = mapped_column(
        String(255), nullable=False, unique=False
    )
    escalada: Mapped[Optional[str]] = mapped_column(
        String(255), nullable=True, unique=False
    )
    numeracao_da_escalada: Mapped[Optional[int]] = mapped_column(
        Integer, nullable=True, unique=False
    )
    local_da_escalada: Mapped[Optional[str]] = mapped_column(
        String(255), nullable=True, unique=False
    )