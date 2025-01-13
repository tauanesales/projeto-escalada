SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


CREATE SCHEMA public; -- Remover se o schema já existir

COMMENT ON SCHEMA public IS 'standard public schema';


CREATE TYPE public.tipousuarioenum AS ENUM (
    'ADMIN',
    'PADRAO'
);


SET default_tablespace = '';

SET default_table_access_method = heap;


CREATE TABLE public."Avisos" (
    titulo character varying(255) NOT NULL,
    texto text NOT NULL,
    id integer NOT NULL,
    criado_em timestamp without time zone NOT NULL,
    atualizado_em timestamp without time zone NOT NULL,
    deletado_em timestamp without time zone,
    CONSTRAINT texto_length_check CHECK ((length(texto) >= length((titulo)::text)))
);


CREATE SEQUENCE public."Avisos_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Avisos_id_seq" OWNED BY public."Avisos".id;


CREATE TABLE public."Categoria" (
    nome character varying(255) NOT NULL,
    descricao text NOT NULL,
    id integer NOT NULL,
    criado_em timestamp without time zone NOT NULL,
    atualizado_em timestamp without time zone NOT NULL,
    deletado_em timestamp without time zone
);


CREATE SEQUENCE public."Categoria_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Categoria_id_seq" OWNED BY public."Categoria".id;


CREATE TABLE public."Musicas" (
    nome character varying(255) NOT NULL,
    letra text NOT NULL,
    "fk_Usuarios_id" integer NOT NULL,
    "fk_Categoria_id" integer NOT NULL,
    id integer NOT NULL,
    criado_em timestamp without time zone NOT NULL,
    atualizado_em timestamp without time zone NOT NULL,
    deletado_em timestamp without time zone,
    CONSTRAINT letra_length_check CHECK ((length(letra) >= length((nome)::text)))
);


CREATE SEQUENCE public."Musicas_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Musicas_id_seq" OWNED BY public."Musicas".id;


CREATE TABLE public."Notificacoes" (
    "fk_Usuarios_id" integer NOT NULL,
    titulo character varying(255) NOT NULL,
    id integer NOT NULL,
    criado_em timestamp without time zone NOT NULL,
    atualizado_em timestamp without time zone NOT NULL,
    deletado_em timestamp without time zone
);


CREATE SEQUENCE public."Notificacoes_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Notificacoes_id_seq" OWNED BY public."Notificacoes".id;


CREATE TABLE public."Usuario_Aviso" (
    "fk_Usuarios_id" integer NOT NULL,
    "fk_Avisos_id" integer NOT NULL
);


CREATE TABLE public."Usuarios" (
    nome character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    senha character varying(255) NOT NULL,
    tipo_usuario public.tipousuarioenum NOT NULL,
    token_reset_senha character varying(5),
    id integer NOT NULL,
    criado_em timestamp without time zone NOT NULL,
    atualizado_em timestamp without time zone NOT NULL,
    deletado_em timestamp without time zone
);


CREATE SEQUENCE public."Usuarios_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Usuarios_id_seq" OWNED BY public."Usuarios".id;


ALTER TABLE ONLY public."Avisos" ALTER COLUMN id SET DEFAULT nextval('public."Avisos_id_seq"'::regclass);


ALTER TABLE ONLY public."Categoria" ALTER COLUMN id SET DEFAULT nextval('public."Categoria_id_seq"'::regclass);


ALTER TABLE ONLY public."Musicas" ALTER COLUMN id SET DEFAULT nextval('public."Musicas_id_seq"'::regclass);


ALTER TABLE ONLY public."Notificacoes" ALTER COLUMN id SET DEFAULT nextval('public."Notificacoes_id_seq"'::regclass);


ALTER TABLE ONLY public."Usuarios" ALTER COLUMN id SET DEFAULT nextval('public."Usuarios_id_seq"'::regclass);


SELECT pg_catalog.setval('public."Avisos_id_seq"', 1, false);


SELECT pg_catalog.setval('public."Categoria_id_seq"', 1, false);


SELECT pg_catalog.setval('public."Musicas_id_seq"', 1, false);


SELECT pg_catalog.setval('public."Notificacoes_id_seq"', 1, false);


SELECT pg_catalog.setval('public."Usuarios_id_seq"', 1, false);


ALTER TABLE ONLY public."Avisos"
    ADD CONSTRAINT "Avisos_pkey" PRIMARY KEY (id);


ALTER TABLE ONLY public."Categoria"
    ADD CONSTRAINT "Categoria_pkey" PRIMARY KEY (id);


ALTER TABLE ONLY public."Musicas"
    ADD CONSTRAINT "Musicas_pkey" PRIMARY KEY (id);


ALTER TABLE ONLY public."Notificacoes"
    ADD CONSTRAINT "Notificacoes_pkey" PRIMARY KEY (id);


ALTER TABLE ONLY public."Usuarios"
    ADD CONSTRAINT "Usuarios_pkey" PRIMARY KEY (id);


CREATE INDEX "ix_Avisos_id" ON public."Avisos" USING btree (id);


CREATE INDEX "ix_Categoria_id" ON public."Categoria" USING btree (id);


CREATE INDEX "ix_Musicas_fk_Categoria_id" ON public."Musicas" USING btree ("fk_Categoria_id");


CREATE INDEX "ix_Musicas_fk_Usuarios_id" ON public."Musicas" USING btree ("fk_Usuarios_id");


CREATE INDEX "ix_Musicas_id" ON public."Musicas" USING btree (id);


CREATE INDEX "ix_Notificacoes_fk_Usuarios_id" ON public."Notificacoes" USING btree ("fk_Usuarios_id");


CREATE INDEX "ix_Notificacoes_id" ON public."Notificacoes" USING btree (id);


CREATE INDEX "ix_Usuario_Aviso_fk_Avisos_id" ON public."Usuario_Aviso" USING btree ("fk_Avisos_id");


CREATE INDEX "ix_Usuario_Aviso_fk_Usuarios_id" ON public."Usuario_Aviso" USING btree ("fk_Usuarios_id");


CREATE INDEX "ix_Usuarios_email" ON public."Usuarios" USING btree (email);


CREATE INDEX "ix_Usuarios_id" ON public."Usuarios" USING btree (id);


ALTER TABLE ONLY public."Musicas"
    ADD CONSTRAINT "Musicas_fk_Categoria_id_fkey" FOREIGN KEY ("fk_Categoria_id") REFERENCES public."Categoria"(id);


ALTER TABLE ONLY public."Musicas"
    ADD CONSTRAINT "Musicas_fk_Usuarios_id_fkey" FOREIGN KEY ("fk_Usuarios_id") REFERENCES public."Usuarios"(id);


ALTER TABLE ONLY public."Notificacoes"
    ADD CONSTRAINT "Notificacoes_fk_Usuarios_id_fkey" FOREIGN KEY ("fk_Usuarios_id") REFERENCES public."Usuarios"(id);


ALTER TABLE ONLY public."Usuario_Aviso"
    ADD CONSTRAINT "Usuario_Aviso_fk_Avisos_id_fkey" FOREIGN KEY ("fk_Avisos_id") REFERENCES public."Avisos"(id);


ALTER TABLE ONLY public."Usuario_Aviso"
    ADD CONSTRAINT "Usuario_Aviso_fk_Usuarios_id_fkey" FOREIGN KEY ("fk_Usuarios_id") REFERENCES public."Usuarios"(id);
