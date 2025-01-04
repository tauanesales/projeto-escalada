from datetime import date, datetime, timedelta
from typing import Optional
import uuid
from sqlalchemy import UUID, Date, DateTime, ForeignKey, Integer, String
from sqlalchemy.orm import Mapped, mapped_column, relationship

from src.database.models.base.entity_model_base import EntityModelBase


class GerarAcessoAdmin(EntityModelBase):
    __tablename__ = "gerar_acesso_admin"

    token: Mapped[uuid.UUID] = mapped_column(
        UUID, nullable=False, unique=True, index=True
    )
    expira_em: Mapped[datetime] = mapped_column(
        DateTime(), nullable=False, unique=False, default=datetime.utcnow() + timedelta(minutes=30),
    )
    descricao: Mapped[Optional[str]] = mapped_column(
        String(255), nullable=True, unique=False
    )

    criador_id: Mapped[int] = mapped_column(ForeignKey("usuarios.id"), nullable=False, index=True)
    # criador: Mapped["Usuario"] = relationship(  # noqa: F821
    #     "Usuario", lazy="joined", uselist=False
    # )
