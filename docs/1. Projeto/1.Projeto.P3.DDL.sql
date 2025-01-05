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

CREATE SCHEMA public;
ALTER SCHEMA public OWNER TO pg_database_owner;
COMMENT ON SCHEMA public IS 'standard public schema';


CREATE TYPE public.statussolicitacaodemusicaenum AS ENUM (
    'PENDENTE',
    'ACEITA',
    'RECUSADA'
);


ALTER TYPE public.statussolicitacaodemusicaenum OWNER TO postgres;


CREATE TYPE public.tiposolicitacaodemusicaenum AS ENUM (
    'CRIAR',
    'ATUALIZAR',
    'REMOVER'
);


ALTER TYPE public.tiposolicitacaodemusicaenum OWNER TO postgres;


CREATE TYPE public.tipousuarioenum AS ENUM (
    'ADMIN',
    'PADRAO'
);


ALTER TYPE public.tipousuarioenum OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

CREATE TABLE public.autor_musica (
    musica_id integer NOT NULL,
    autor_id integer NOT NULL,
    papel character varying(255) NOT NULL,
    id integer NOT NULL,
    criado_em timestamp without time zone NOT NULL,
    atualizado_em timestamp without time zone NOT NULL,
    deletado_em timestamp without time zone
);


ALTER TABLE public.autor_musica OWNER TO postgres;


CREATE SEQUENCE public.autor_musica_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.autor_musica_id_seq OWNER TO postgres;

ALTER SEQUENCE public.autor_musica_id_seq OWNED BY public.autor_musica.id;


CREATE TABLE public.autores (
    nome character varying(255) NOT NULL,
    escalada character varying(255),
    numeracao_da_escalada integer,
    local_da_escalada character varying(255),
    id integer NOT NULL,
    criado_em timestamp without time zone NOT NULL,
    atualizado_em timestamp without time zone NOT NULL,
    deletado_em timestamp without time zone
);


ALTER TABLE public.autores OWNER TO postgres;


CREATE SEQUENCE public.autores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.autores_id_seq OWNER TO postgres;


ALTER SEQUENCE public.autores_id_seq OWNED BY public.autores.id;



CREATE TABLE public.avisos (
    criador_id integer NOT NULL,
    titulo character varying(255) NOT NULL,
    texto text NOT NULL,
    id integer NOT NULL,
    criado_em timestamp without time zone NOT NULL,
    atualizado_em timestamp without time zone NOT NULL,
    deletado_em timestamp without time zone
);


ALTER TABLE public.avisos OWNER TO postgres;



CREATE SEQUENCE public.avisos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.avisos_id_seq OWNER TO postgres;


ALTER SEQUENCE public.avisos_id_seq OWNED BY public.avisos.id;



CREATE TABLE public.foto_historico_edicoes_dashboard (
    historico_edicao_dashboard_id integer NOT NULL,
    foto_id integer NOT NULL,
    id integer NOT NULL,
    criado_em timestamp without time zone NOT NULL,
    atualizado_em timestamp without time zone NOT NULL,
    deletado_em timestamp without time zone
);


ALTER TABLE public.foto_historico_edicoes_dashboard OWNER TO postgres;


CREATE SEQUENCE public.foto_historico_edicoes_dashboard_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.foto_historico_edicoes_dashboard_id_seq OWNER TO postgres;


ALTER SEQUENCE public.foto_historico_edicoes_dashboard_id_seq OWNED BY public.foto_historico_edicoes_dashboard.id;



CREATE TABLE public.fotos (
    criador_id integer NOT NULL,
    titulo character varying(255),
    descricao character varying(4096),
    url character varying(4096) NOT NULL,
    ativo boolean NOT NULL,
    id integer NOT NULL,
    criado_em timestamp without time zone NOT NULL,
    atualizado_em timestamp without time zone NOT NULL,
    deletado_em timestamp without time zone
);


ALTER TABLE public.fotos OWNER TO postgres;


CREATE SEQUENCE public.fotos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.fotos_id_seq OWNER TO postgres;


ALTER SEQUENCE public.fotos_id_seq OWNED BY public.fotos.id;



CREATE TABLE public.gerar_acesso_admin (
    token uuid NOT NULL,
    expira_em timestamp without time zone NOT NULL,
    descricao character varying(255),
    criador_id integer NOT NULL,
    id integer NOT NULL,
    criado_em timestamp without time zone NOT NULL,
    atualizado_em timestamp without time zone NOT NULL,
    deletado_em timestamp without time zone
);


ALTER TABLE public.gerar_acesso_admin OWNER TO postgres;


CREATE SEQUENCE public.gerar_acesso_admin_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.gerar_acesso_admin_id_seq OWNER TO postgres;


ALTER SEQUENCE public.gerar_acesso_admin_id_seq OWNED BY public.gerar_acesso_admin.id;



CREATE TABLE public.historico_edicoes_dashboard (
    editor_id integer NOT NULL,
    titulo character varying(255) NOT NULL,
    texto character varying(4096) NOT NULL,
    id integer NOT NULL,
    criado_em timestamp without time zone NOT NULL,
    atualizado_em timestamp without time zone NOT NULL,
    deletado_em timestamp without time zone
);


ALTER TABLE public.historico_edicoes_dashboard OWNER TO postgres;


CREATE SEQUENCE public.historico_edicoes_dashboard_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.historico_edicoes_dashboard_id_seq OWNER TO postgres;


ALTER SEQUENCE public.historico_edicoes_dashboard_id_seq OWNED BY public.historico_edicoes_dashboard.id;



CREATE TABLE public.musicas (
    titulo character varying(255) NOT NULL,
    letra text NOT NULL,
    id integer NOT NULL,
    criado_em timestamp without time zone NOT NULL,
    atualizado_em timestamp without time zone NOT NULL,
    deletado_em timestamp without time zone
);


ALTER TABLE public.musicas OWNER TO postgres;


CREATE SEQUENCE public.musicas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.musicas_id_seq OWNER TO postgres;


ALTER SEQUENCE public.musicas_id_seq OWNED BY public.musicas.id;



CREATE TABLE public.notificacoes (
    usuario_id integer NOT NULL,
    visto_em date,
    texto character varying(255) NOT NULL,
    id integer NOT NULL,
    criado_em timestamp without time zone NOT NULL,
    atualizado_em timestamp without time zone NOT NULL,
    deletado_em timestamp without time zone
);


ALTER TABLE public.notificacoes OWNER TO postgres;


CREATE SEQUENCE public.notificacoes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notificacoes_id_seq OWNER TO postgres;


ALTER SEQUENCE public.notificacoes_id_seq OWNED BY public.notificacoes.id;



CREATE TABLE public.solicitacoes_de_musica (
    solicitante_id integer NOT NULL,
    status public.statussolicitacaodemusicaenum NOT NULL,
    tipo_solicitacao public.tiposolicitacaodemusicaenum NOT NULL,
    avaliador_id integer,
    avaliado_em date,
    id integer NOT NULL,
    criado_em timestamp without time zone NOT NULL,
    atualizado_em timestamp without time zone NOT NULL,
    deletado_em timestamp without time zone,
    CONSTRAINT check_avaliador_and_avaliado_em CHECK ((((avaliador_id IS NOT NULL) AND (avaliado_em IS NOT NULL)) OR ((avaliador_id IS NULL) AND (avaliado_em IS NULL))))
);


ALTER TABLE public.solicitacoes_de_musica OWNER TO postgres;


CREATE SEQUENCE public.solicitacoes_de_musica_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.solicitacoes_de_musica_id_seq OWNER TO postgres;


ALTER SEQUENCE public.solicitacoes_de_musica_id_seq OWNED BY public.solicitacoes_de_musica.id;



CREATE TABLE public.usuario_foto (
    usuario_id integer NOT NULL,
    foto_id integer NOT NULL,
    principal boolean NOT NULL,
    id integer NOT NULL,
    criado_em timestamp without time zone NOT NULL,
    atualizado_em timestamp without time zone NOT NULL,
    deletado_em timestamp without time zone
);


ALTER TABLE public.usuario_foto OWNER TO postgres;


CREATE SEQUENCE public.usuario_foto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuario_foto_id_seq OWNER TO postgres;


ALTER SEQUENCE public.usuario_foto_id_seq OWNED BY public.usuario_foto.id;



CREATE TABLE public.usuarios (
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


ALTER TABLE public.usuarios OWNER TO postgres;


CREATE SEQUENCE public.usuarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuarios_id_seq OWNER TO postgres;


ALTER SEQUENCE public.usuarios_id_seq OWNED BY public.usuarios.id;



ALTER TABLE ONLY public.autor_musica ALTER COLUMN id SET DEFAULT nextval('public.autor_musica_id_seq'::regclass);



ALTER TABLE ONLY public.autores ALTER COLUMN id SET DEFAULT nextval('public.autores_id_seq'::regclass);



ALTER TABLE ONLY public.avisos ALTER COLUMN id SET DEFAULT nextval('public.avisos_id_seq'::regclass);



ALTER TABLE ONLY public.foto_historico_edicoes_dashboard ALTER COLUMN id SET DEFAULT nextval('public.foto_historico_edicoes_dashboard_id_seq'::regclass);



ALTER TABLE ONLY public.fotos ALTER COLUMN id SET DEFAULT nextval('public.fotos_id_seq'::regclass);



ALTER TABLE ONLY public.gerar_acesso_admin ALTER COLUMN id SET DEFAULT nextval('public.gerar_acesso_admin_id_seq'::regclass);



ALTER TABLE ONLY public.historico_edicoes_dashboard ALTER COLUMN id SET DEFAULT nextval('public.historico_edicoes_dashboard_id_seq'::regclass);



ALTER TABLE ONLY public.musicas ALTER COLUMN id SET DEFAULT nextval('public.musicas_id_seq'::regclass);



ALTER TABLE ONLY public.notificacoes ALTER COLUMN id SET DEFAULT nextval('public.notificacoes_id_seq'::regclass);



ALTER TABLE ONLY public.solicitacoes_de_musica ALTER COLUMN id SET DEFAULT nextval('public.solicitacoes_de_musica_id_seq'::regclass);



ALTER TABLE ONLY public.usuario_foto ALTER COLUMN id SET DEFAULT nextval('public.usuario_foto_id_seq'::regclass);



ALTER TABLE ONLY public.usuarios ALTER COLUMN id SET DEFAULT nextval('public.usuarios_id_seq'::regclass);







































SELECT pg_catalog.setval('public.autor_musica_id_seq', 1, false);



SELECT pg_catalog.setval('public.autores_id_seq', 1, false);



SELECT pg_catalog.setval('public.avisos_id_seq', 1, false);



SELECT pg_catalog.setval('public.foto_historico_edicoes_dashboard_id_seq', 1, false);



SELECT pg_catalog.setval('public.fotos_id_seq', 1, false);



SELECT pg_catalog.setval('public.gerar_acesso_admin_id_seq', 1, false);



SELECT pg_catalog.setval('public.historico_edicoes_dashboard_id_seq', 1, false);



SELECT pg_catalog.setval('public.musicas_id_seq', 1, false);



SELECT pg_catalog.setval('public.notificacoes_id_seq', 1, false);



SELECT pg_catalog.setval('public.solicitacoes_de_musica_id_seq', 1, false);



SELECT pg_catalog.setval('public.usuario_foto_id_seq', 1, false);



SELECT pg_catalog.setval('public.usuarios_id_seq', 1, false);



ALTER TABLE ONLY public.autor_musica
    ADD CONSTRAINT autor_musica_pkey PRIMARY KEY (id);



ALTER TABLE ONLY public.autores
    ADD CONSTRAINT autores_pkey PRIMARY KEY (id);



ALTER TABLE ONLY public.avisos
    ADD CONSTRAINT avisos_pkey PRIMARY KEY (id);



ALTER TABLE ONLY public.foto_historico_edicoes_dashboard
    ADD CONSTRAINT foto_historico_edicoes_dashboard_pkey PRIMARY KEY (id);



ALTER TABLE ONLY public.fotos
    ADD CONSTRAINT fotos_pkey PRIMARY KEY (id);



ALTER TABLE ONLY public.gerar_acesso_admin
    ADD CONSTRAINT gerar_acesso_admin_pkey PRIMARY KEY (id);



ALTER TABLE ONLY public.historico_edicoes_dashboard
    ADD CONSTRAINT historico_edicoes_dashboard_pkey PRIMARY KEY (id);



ALTER TABLE ONLY public.musicas
    ADD CONSTRAINT musicas_pkey PRIMARY KEY (id);



ALTER TABLE ONLY public.notificacoes
    ADD CONSTRAINT notificacoes_pkey PRIMARY KEY (id);



ALTER TABLE ONLY public.solicitacoes_de_musica
    ADD CONSTRAINT solicitacoes_de_musica_pkey PRIMARY KEY (id);



ALTER TABLE ONLY public.usuario_foto
    ADD CONSTRAINT uq_usuario_principal UNIQUE (usuario_id, principal);



ALTER TABLE ONLY public.usuario_foto
    ADD CONSTRAINT usuario_foto_pkey PRIMARY KEY (id);



ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);



CREATE INDEX ix_autor_musica_id ON public.autor_musica USING btree (id);



CREATE INDEX ix_autor_musica_papel ON public.autor_musica USING btree (papel);



CREATE INDEX ix_autores_id ON public.autores USING btree (id);



CREATE INDEX ix_avisos_criador_id ON public.avisos USING btree (criador_id);



CREATE INDEX ix_avisos_id ON public.avisos USING btree (id);



CREATE INDEX ix_foto_historico_edicoes_dashboard_id ON public.foto_historico_edicoes_dashboard USING btree (id);



CREATE INDEX ix_fotos_criador_id ON public.fotos USING btree (criador_id);



CREATE INDEX ix_fotos_id ON public.fotos USING btree (id);



CREATE INDEX ix_gerar_acesso_admin_criador_id ON public.gerar_acesso_admin USING btree (criador_id);



CREATE INDEX ix_gerar_acesso_admin_id ON public.gerar_acesso_admin USING btree (id);



CREATE UNIQUE INDEX ix_gerar_acesso_admin_token ON public.gerar_acesso_admin USING btree (token);



CREATE INDEX ix_historico_edicoes_dashboard_editor_id ON public.historico_edicoes_dashboard USING btree (editor_id);



CREATE INDEX ix_historico_edicoes_dashboard_id ON public.historico_edicoes_dashboard USING btree (id);



CREATE INDEX ix_musicas_id ON public.musicas USING btree (id);



CREATE INDEX ix_notificacoes_id ON public.notificacoes USING btree (id);



CREATE INDEX ix_notificacoes_usuario_id ON public.notificacoes USING btree (usuario_id);



CREATE INDEX ix_solicitacoes_de_musica_id ON public.solicitacoes_de_musica USING btree (id);



CREATE INDEX ix_usuario_foto_id ON public.usuario_foto USING btree (id);



CREATE INDEX ix_usuarios_email ON public.usuarios USING btree (email);



CREATE INDEX ix_usuarios_id ON public.usuarios USING btree (id);



ALTER TABLE ONLY public.autor_musica
    ADD CONSTRAINT autor_musica_autor_id_fkey FOREIGN KEY (autor_id) REFERENCES public.autores(id);



ALTER TABLE ONLY public.autor_musica
    ADD CONSTRAINT autor_musica_musica_id_fkey FOREIGN KEY (musica_id) REFERENCES public.musicas(id);



ALTER TABLE ONLY public.avisos
    ADD CONSTRAINT avisos_criador_id_fkey FOREIGN KEY (criador_id) REFERENCES public.usuarios(id);



ALTER TABLE ONLY public.foto_historico_edicoes_dashboard
    ADD CONSTRAINT foto_historico_edicoes_dashbo_historico_edicao_dashboard_i_fkey FOREIGN KEY (historico_edicao_dashboard_id) REFERENCES public.historico_edicoes_dashboard(id);



ALTER TABLE ONLY public.foto_historico_edicoes_dashboard
    ADD CONSTRAINT foto_historico_edicoes_dashboard_foto_id_fkey FOREIGN KEY (foto_id) REFERENCES public.fotos(id);



ALTER TABLE ONLY public.fotos
    ADD CONSTRAINT fotos_criador_id_fkey FOREIGN KEY (criador_id) REFERENCES public.usuarios(id);



ALTER TABLE ONLY public.gerar_acesso_admin
    ADD CONSTRAINT gerar_acesso_admin_criador_id_fkey FOREIGN KEY (criador_id) REFERENCES public.usuarios(id);



ALTER TABLE ONLY public.historico_edicoes_dashboard
    ADD CONSTRAINT historico_edicoes_dashboard_editor_id_fkey FOREIGN KEY (editor_id) REFERENCES public.usuarios(id);



ALTER TABLE ONLY public.notificacoes
    ADD CONSTRAINT notificacoes_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id);



ALTER TABLE ONLY public.solicitacoes_de_musica
    ADD CONSTRAINT solicitacoes_de_musica_avaliador_id_fkey FOREIGN KEY (avaliador_id) REFERENCES public.usuarios(id);



ALTER TABLE ONLY public.solicitacoes_de_musica
    ADD CONSTRAINT solicitacoes_de_musica_solicitante_id_fkey FOREIGN KEY (solicitante_id) REFERENCES public.usuarios(id);



ALTER TABLE ONLY public.usuario_foto
    ADD CONSTRAINT usuario_foto_foto_id_fkey FOREIGN KEY (foto_id) REFERENCES public.fotos(id);



ALTER TABLE ONLY public.usuario_foto
    ADD CONSTRAINT usuario_foto_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id);
