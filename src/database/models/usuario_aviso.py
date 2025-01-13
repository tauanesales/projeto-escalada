from sqlalchemy import ForeignKey
from sqlalchemy.orm import Mapped, mapped_column

from src.database.models.base.entity_model_base import EntityModelBase


class UsuarioAviso(EntityModelBase):
    __tablename__ = "Usuario_Aviso"

    fk_Usuarios_id: Mapped[int] = mapped_column(
        ForeignKey("Usuarios.id"), nullable=False, index=True, primary_key=True
    )
    fk_Avisos_id: Mapped[int] = mapped_column(
        ForeignKey("Avisos.id"), nullable=False, index=True, primary_key=True
    )
