"""Inserção de dados sintéticos

Revision ID: a5d71df7f127
Revises: 9937098d2ec1
Create Date: 2025-01-05 00:32:35.605834

"""

from datetime import datetime
import random
import string
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa

from src.database.models.usuario import Usuario
from src.database.models.aviso import Aviso
from src.database.models.musica import Musica
from datetime import datetime, timedelta

from src.utils.enums import TipoUsuarioEnum


# revision identifiers, used by Alembic.
revision: str = "a5d71df7f127"
down_revision: Union[str, None] = "9937098d2ec1"
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def generate_random_text(
    min_length: int = 4, max_length: int = 40, linebreak: bool = False
) -> str:
    word_length = random.randint(min_length, max_length)
    characters = string.ascii_lowercase * 2 + ".,    "

    if linebreak:
        characters += "\n\n\n"

    random_text = "".join(random.choices(characters, k=word_length))

    sentences = random_text.split(",")
    sentences = [
        sentence.strip().strip(".")
        for sentence in sentences
        if sentence.strip().strip(".")
    ]
    random_text = ", ".join(sentences)

    sentences = random_text.split("\n")
    sentences = [sentence.strip().capitalize() for sentence in sentences]
    random_text = ".\n\n".join(sentences)

    sentences = random_text.split(".")
    sentences = [
        sentence.strip().capitalize() for sentence in sentences if sentence.strip()
    ]
    random_text = ". ".join(sentences)

    if not random_text.endswith("."):
        random_text += "."

    return random_text


def generate_base_dates(iteration: int):
    return {
        "criado_em": (
            random_date := datetime.strptime("2011-01-01", "%Y-%m-%d")
            + timedelta(days=iteration)
        ),
        "atualizado_em": (
            last_update := random_date
            + timedelta(
                days=random.choice(
                    [
                        0,
                        random.randint(1, 30),
                        random.randint(30, 120),
                        random.randint(120, 700),
                    ]
                )
            )
        ),
        "deletado_em": random.choice(
            [
                None,
                None,
                None,
                None,
                None,
                None,
                None,
                last_update
                + timedelta(
                    days=random.choice(
                        [
                            0,
                            random.randint(1, 30),
                            random.randint(30, 120),
                            random.randint(120, 700),
                        ]
                    )
                ),
            ]
        ),
    }


def upgrade() -> None:
    op.bulk_insert(
        Musica.__table__,
        [
            {
                "titulo": generate_random_text(),
                "letra": generate_random_text(max_length=3000, linebreak=True),
                **generate_base_dates(iteration),
            }
            for iteration in range(5000)
        ],
    )

    op.bulk_insert(
        Usuario.__table__,
        [
            {
                'nome': generate_random_text().replace(",","").replace(".",""),
                'email': f"{iteration}@email.com",
                'senha': "UMA_SENHA_MUITO_SEGURA_E_ENCRIPTADA",
                'tipo_usuario': TipoUsuarioEnum.ADMIN,
                'token_reset_senha': None,
                **generate_base_dates(iteration),
                "deletado_em": None
            }
            for iteration in range(20)
        ],
    )
    
    op.bulk_insert(
        Usuario.__table__,
        [
            {
                'nome': generate_random_text().replace(",","").replace(".",""),
                'email': f"{iteration}@email.com",
                'senha': "UMA_SENHA_MUITO_SEGURA_E_ENCRIPTADA",
                'tipo_usuario': TipoUsuarioEnum.PADRAO,
                'token_reset_senha': None,
                **generate_base_dates(iteration),
            }
            for iteration in range(20,5000)
        ],
    )

    op.bulk_insert(
        Aviso.__table__,
        [
            {
                "criador_id": random.randint(1,20),
                "titulo": generate_random_text(),
                "texto": generate_random_text(max_length=800, linebreak=True),
                **generate_base_dates(iteration),
            }
            for iteration in range(5000)
        ],
    )


def downgrade() -> None:
    pass
