from sqlalchemy import Enum, ForeignKey, String, Text
from sqlalchemy.orm import Mapped, mapped_column, relationship

from src.database.models.base.entity_model_base import EntityModelBase
from src.utils.enums import TipoUsuarioEnum


class Musica(EntityModelBase):
    __tablename__ = "musicas"

    titulo: Mapped[str] = mapped_column(String(255), nullable=False)
    letra: Mapped[str] = mapped_column(Text, nullable=False)

    # autores: Mapped["Autor"] = relationship(  # noqa: F821
    #     "Autor",
    #     secondary='music_author',
    #     lazy="joined",
    # )
