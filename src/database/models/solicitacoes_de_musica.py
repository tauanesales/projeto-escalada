from datetime import date
from typing import Optional
from sqlalchemy import CheckConstraint, Date, Enum, ForeignKey
from sqlalchemy.orm import Mapped, mapped_column, relationship

from src.database.models.base.entity_model_base import EntityModelBase
from src.utils.enums import StatusSolicitacaoDeMusicaEnum, TipoSolicitacaoDeMusicaEnum


class SolicitacaoDeMusica(EntityModelBase):
    __tablename__ = "solicitacoes_de_musica"

    solicitante_id: Mapped[int] = mapped_column(ForeignKey("usuarios.id"), nullable=False)
    # solicitante: Mapped["Usuario"] = relationship(  # noqa: F821
    #     "Usuario", back_populates="solicitacoes", lazy="joined", uselist=False
    # )

    status: Mapped[StatusSolicitacaoDeMusicaEnum] = mapped_column(
        Enum(StatusSolicitacaoDeMusicaEnum), nullable=False
    )

    tipo_solicitacao: Mapped[TipoSolicitacaoDeMusicaEnum] = mapped_column(
        Enum(TipoSolicitacaoDeMusicaEnum), nullable=False
    )

    avaliador_id: Mapped[Optional[int]] = mapped_column(ForeignKey("usuarios.id"), nullable=True)
    # avaliador: Mapped["Usuario"] = relationship(  # noqa: F821
    #     "Usuario", back_populates="solicitacoes", lazy="joined", uselist=False
    # )

    avaliado_em: Mapped[Optional[date]] = mapped_column(Date(), nullable=True)

    __table_args__ = (
        CheckConstraint(
            "(avaliador_id IS NOT NULL AND avaliado_em IS NOT NULL) OR "
            "(avaliador_id IS NULL AND avaliado_em IS NULL)",
            name="check_avaliador_and_avaliado_em",
        ),
    )
