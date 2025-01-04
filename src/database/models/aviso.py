from datetime import date
from typing import Optional
from sqlalchemy import Date, ForeignKey, String, Text
from sqlalchemy.orm import Mapped, mapped_column, relationship

from src.database.models.base.entity_model_base import EntityModelBase


class Aviso(EntityModelBase):
    __tablename__ = "avisos"

    criador_id: Mapped[int] = mapped_column(ForeignKey("usuarios.id"), nullable=False, index=True)
    # criador: Mapped["Usuario"] = relationship(  # noqa: F821
    #     "Usuario", lazy="joined", uselist=False
    # )

    titulo: Mapped[str] = mapped_column(String(255), nullable=False)
    texto: Mapped[str] = mapped_column(Text, nullable=False)
