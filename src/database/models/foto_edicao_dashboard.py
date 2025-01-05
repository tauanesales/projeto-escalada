from sqlalchemy import ForeignKey, Integer
from sqlalchemy.orm import Mapped, mapped_column

from src.database.models.base.entity_model_base import EntityModelBase


class FotoEdicaoDashboard(EntityModelBase):
    __tablename__ = "foto_historico_edicoes_dashboard"

    historico_edicao_dashboard_id: Mapped[int] = mapped_column(
        Integer, ForeignKey("historico_edicoes_dashboard.id")
    )
    foto_id: Mapped[int] = mapped_column(Integer, ForeignKey("fotos.id"))
