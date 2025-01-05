from sqlalchemy import Boolean, ForeignKey, Integer, UniqueConstraint
from sqlalchemy.orm import Mapped, mapped_column

from src.database.models.base.entity_model_base import EntityModelBase


class UsuarioFoto(EntityModelBase):
    __tablename__ = "usuario_foto"

    usuario_id: Mapped[int] = mapped_column(Integer, ForeignKey("usuarios.id"))
    foto_id: Mapped[int] = mapped_column(Integer, ForeignKey("fotos.id"))
    principal: Mapped[bool] = mapped_column(Boolean, nullable=False, default=False)

    __table_args__ = (
        UniqueConstraint("usuario_id", "principal", name="uq_usuario_principal"),
    )
