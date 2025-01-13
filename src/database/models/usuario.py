from typing import Optional

from sqlalchemy import Enum, String
from sqlalchemy.orm import Mapped, mapped_column

from src.database.models.base.entity_model_base import EntityModelBase
from src.utils.enums import TipoUsuarioEnum


class Usuario(EntityModelBase):
    __tablename__ = "Usuarios"

    nome: Mapped[str] = mapped_column(String(255), nullable=False, unique=False)
    email: Mapped[str] = mapped_column(
        String(255), nullable=False, unique=False, index=True
    )
    senha: Mapped[str] = mapped_column(String(255), nullable=False)

    tipo_usuario: Mapped[TipoUsuarioEnum] = mapped_column(
        Enum(TipoUsuarioEnum), nullable=False
    )
    token_reset_senha: Mapped[Optional[str]] = mapped_column(String(5), nullable=True)
