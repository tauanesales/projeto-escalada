from sqlalchemy import CheckConstraint, String, Text
from sqlalchemy.orm import Mapped, mapped_column

from src.database.models.base.entity_model_base import EntityModelBase


class Aviso(EntityModelBase):
    __tablename__ = "Avisos"

    titulo: Mapped[str] = mapped_column(String(255), nullable=False)
    texto: Mapped[str] = mapped_column(Text, nullable=False)

    __table_args__ = (
        CheckConstraint("LENGTH(texto) >= LENGTH(titulo)", name="texto_length_check"),
    )
