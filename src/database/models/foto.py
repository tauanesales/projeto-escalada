from typing import Optional
from sqlalchemy import Boolean, Enum, ForeignKey, String
from sqlalchemy.orm import Mapped, mapped_column, relationship

from src.database.models.base.entity_model_base import EntityModelBase
from src.utils.enums import TipoUsuarioEnum


class Foto(EntityModelBase):
    __tablename__ = "fotos"

    criador_id: Mapped[int] = mapped_column(ForeignKey("usuarios.id"), nullable=False, index=True)
    # criador: Mapped["Usuario"] = relationship(  # noqa: F821
    #     "Usuario", lazy="joined", uselist=False
    # )
    titulo: Mapped[Optional[str]] = mapped_column(String(255), nullable=True)
    descricao: Mapped[Optional[str]] = mapped_column(String(4096), nullable=True)
    url: Mapped[str] = mapped_column(String(4096), nullable=False)
    ativo: Mapped[bool]= mapped_column(Boolean, nullable=False, default=True)