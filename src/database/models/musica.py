from sqlalchemy import CheckConstraint, ForeignKey, String, Text
from sqlalchemy.orm import Mapped, mapped_column

from src.database.models.base.entity_model_base import EntityModelBase


class Musica(EntityModelBase):
    __tablename__ = "Musicas"

    nome: Mapped[str] = mapped_column(String(255), nullable=False)
    letra: Mapped[str] = mapped_column(Text, nullable=False)
    fk_Usuarios_id: Mapped[int] = mapped_column(
        ForeignKey("Usuarios.id"), nullable=False, index=True
    )
    fk_Categoria_id: Mapped[int] = mapped_column(
        ForeignKey("Categoria.id"), nullable=False, index=True
    )
    # autores: Mapped["Autor"] = relationship(  # noqa: F821
    #     "Autor",
    #     secondary='music_author',
    #     lazy="joined",
    # )

    __table_args__ = (
        CheckConstraint("LENGTH(letra) >= LENGTH(nome)", name="letra_length_check"),
    )
