# elasticsearch  postgres fdw learning

## Usage

```code
CREATE EXTENSION multicorn;

CREATE SERVER multicorn_es FOREIGN DATA WRAPPER multicorn
OPTIONS (
  wrapper 'pg_es_fdw.ElasticsearchFDW'
);
CREATE FOREIGN TABLE articles_es
    (
        id BIGINT,
        title TEXT,
        body TEXT,
        query TEXT,
        score NUMERIC
    )
SERVER multicorn_es
OPTIONS
    (
        host 'elasticsearch',
        port '9200',
        index 'article-index',
        type 'article',
        rowid_column 'id',
        query_column 'query',
        score_column 'score',
        timeout '20'
    )
;

INSERT INTO articles_es
    (
        id,
        title,
        body
    )
VALUES
    (
        1,
        'foo',
        'spike'
    );
```
## with postgres_fdw

```code
create extension postgres_fdw;

CREATE SERVER pg_server
  FOREIGN DATA WRAPPER postgres_fdw
  OPTIONS (host 'psotgres-fdw', dbname 'postgres');

CREATE USER MAPPING FOR postgres
  SERVER pg_server
  OPTIONS (user 'postgres', password 'dalong');

CREATE SCHEMA app;
IMPORT FOREIGN SCHEMA public
  FROM SERVER pg_server
  INTO app;

select * from app.articles_es;
```