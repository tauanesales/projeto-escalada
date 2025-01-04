from enum import auto

from strenum import StrEnum


class TipoUsuarioEnum(StrEnum):
    ADMIN = auto()
    PADRAO = auto()


class StatusSolicitacaoDeMusicaEnum(StrEnum):
    PENDENTE = auto()
    ACEITA = auto()
    RECUSADA = auto()


class TipoSolicitacaoDeMusicaEnum(StrEnum):
    CRIAR = auto()
    ATUALIZAR = auto()
    REMOVER = auto()
