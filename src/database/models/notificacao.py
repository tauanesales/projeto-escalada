from datetime import date
from typing import Optional
from sqlalchemy import Date, ForeignKey, String
from sqlalchemy.orm import Mapped, mapped_column, relationship

from src.database.models.base.entity_model_base import EntityModelBase


class Notificacao(EntityModelBase):
    __tablename__ = "notificacoes"

    usuario_id: Mapped[int] = mapped_column(ForeignKey("usuarios.id"), nullable=False, index=True)
    # usuario: Mapped["Usuario"] = relationship(  # noqa: F821
    #     "Usuario", back_populates="solicitacoes", lazy="joined", uselist=False
    # )

    visto_em: Mapped[Optional[date]] = mapped_column(Date(), nullable=True)

    texto: Mapped[str] = mapped_column(String(255), nullable=False)
