from sqlalchemy import ForeignKey, Integer, String
from sqlalchemy.orm import Mapped, mapped_column

from src.database.models.base.entity_model_base import EntityModelBase


class AutorMusica(EntityModelBase):
    __tablename__ = "autor_musica"

    musica_id: Mapped[int] = mapped_column(Integer, ForeignKey("musicas.id"))
    autor_id: Mapped[int] = mapped_column(Integer, ForeignKey("autores.id"))
    papel: Mapped[str] = mapped_column(String(255), nullable=False, index=True)
