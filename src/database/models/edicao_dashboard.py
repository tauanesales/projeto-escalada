from sqlalchemy import ForeignKey, String
from sqlalchemy.orm import Mapped, mapped_column

from src.database.models.base.entity_model_base import EntityModelBase


class EdicaoDashboard(EntityModelBase):
    __tablename__ = "historico_edicoes_dashboard"

    editor_id: Mapped[int] = mapped_column(
        ForeignKey("usuarios.id"), nullable=False, index=True
    )
    # editor: Mapped["Usuario"] = relationship(  # noqa: F821
    #     "Usuario", lazy="joined", uselist=False
    # )

    titulo: Mapped[str] = mapped_column(String(255), nullable=False)
    texto: Mapped[str] = mapped_column(String(4096), nullable=False)
