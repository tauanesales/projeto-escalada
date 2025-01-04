from typing import Optional

from loguru import logger
from sqlalchemy import and_, select, update
from sqlalchemy.ext.asyncio import AsyncSession

from src.database.models.base.entity_model_base import EntityModelBase

class Repository:
    def __init__(self, session: AsyncSession):
        self._session: AsyncSession = session

    async def buscar_por_id(
        self, id: int, model: EntityModelBase
    ) -> Optional[EntityModelBase]:
        query = select(model).where(
            and_(model.id == id, model.deleted_at == None)  # noqa: E711
        )
        result = await self._session.execute(query)
        return result.scalar()

    async def buscar_todos(self, model: EntityModelBase) -> list[EntityModelBase]:
        query = select(model).where(model.deleted_at == None)  # noqa: E711
        result = await self._session.execute(query)
        return result.scalars().unique().all()

    async def filtrar(self, model: EntityModelBase, **kwargs) -> list[EntityModelBase]:
        query = select(model).filter_by(**kwargs)
        result = await self._session.execute(query)
        return result.scalars().unique().all()

    async def criar(self, model: EntityModelBase) -> EntityModelBase:
        self._session.add(model)
        await self._session.flush()
        await self._session.refresh(model)
        return model

    async def salvar(self, model: EntityModelBase = None) -> None:
        await self._session.flush()
        if model:
            await self._session.refresh(model)

    async def atualizar_por_id(self, id: int, model: EntityModelBase, **kwargs) -> None:
        query = update(model).where(model.id == id).values(**kwargs)
        await self._session.execute(query)
        await self._session.flush()
        logger.info(f"{model.__name__} {id=} atualizado com sucesso.")
