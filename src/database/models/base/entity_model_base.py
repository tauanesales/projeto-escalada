from datetime import datetime

from sqlalchemy import DateTime, MetaData
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column


class EntityModelBase(DeclarativeBase):
    __abstract__ = True

    metadata = MetaData()

    id: Mapped[int] = mapped_column(
        nullable=False, primary_key=True, index=True, autoincrement=True
    )
    criado_em: Mapped[datetime] = mapped_column(
        DateTime(), default=datetime.utcnow(), nullable=False
    )
    atualizado_em: Mapped[datetime] = mapped_column(
        DateTime(), default=datetime.utcnow(), nullable=False, onupdate=datetime.utcnow
    )
    deletado_em: Mapped[datetime] = mapped_column(DateTime(), nullable=True)
