{% macro create_source_tables() %}

create schema if not exists raw;

create table if not exists raw.exposure (
    eid text,
    cid text,
    et text,
    tp text,
    id text
);

create table if not exists raw.motor (
    mid text,
    ld text,
    vrn text,
    y text,
    m text,
    mo text,
    ec text,
    col text,
    dd text,
    tld text,
    pav text,
    rc text,
    amfv text,
    pn text,
    ddob text,
    ft text,
    d text,
    s text,
    id text
)

{% endmacro %}