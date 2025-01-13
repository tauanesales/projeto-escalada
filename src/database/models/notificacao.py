from sqlalchemy import ForeignKey, String
from sqlalchemy.orm import Mapped, mapped_column

from src.database.models.base.entity_model_base import EntityModelBase


class Notificacao(EntityModelBase):
    __tablename__ = "Notificacoes"

    fk_Usuarios_id: Mapped[int] = mapped_column(
        ForeignKey("Usuarios.id"), nullable=False, index=True
    )

    titulo: Mapped[str] = mapped_column(String(255), nullable=False)
