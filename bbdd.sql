PGDMP     (    1        
        y            TestPOO    12.5    12.5                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                        0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            !           1262    16393    TestPOO    DATABASE     �   CREATE DATABASE "TestPOO" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Spanish_Spain.1252' LC_CTYPE = 'Spanish_Spain.1252';
    DROP DATABASE "TestPOO";
                postgres    false            �            1255    24595    crpartidos()    FUNCTION     �  CREATE FUNCTION public.crpartidos() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare 
 puntosN integer;
 puntosN1 integer;
 pgN     integer:=0;
 peN 	 integer:=0;
 ppN  	 integer:=0;
 pgN1    integer:=0;
 peN1 	 integer:=0;
 ppN1  	 integer:=0;
 pjN  	 integer:=1;

begin

if exists(select nombre from equipos where nombre=new.equipo_1) then else
   insert into equipos (nombre) values (new.equipo_1);
end if;

if exists(select nombre from equipos where nombre=new.equipo_2) then else
   insert into equipos (nombre) values (new.equipo_2);
end if;

if (new.marcador_e1>new.marcador_e2) then
    puntosN:=3;  puntosN1:=0; pgN:=1; ppN1:=1; 
elsif (new.marcador_e1<new.marcador_e2) then
    puntosN1=3; puntosN:=0; pgN1:=1;  ppN:=1;
else
    puntosN:=1; puntosN1:=1; peN:=1; peN1:=1;
end if;
if exists(select equipo from resultados where equipo=new.equipo_1) then 
  update resultados 
  set puntos=puntosN+puntos,
  	  pg=pg+pgN,
	  pe=pe+peN,
	  pp=pp+ppN,
	  pj=pj+pjN
  where equipo=new.equipo_1;	  
else
  insert into resultados (equipo,puntos,pg,pe,pp,pj) values (new.equipo_1,puntosN,pgN,peN,ppN,pjN);
end if;

if exists(select equipo from resultados where equipo=new.equipo_2) then 
  update resultados 
  set puntos=puntosN1+puntos,
  	  pg=pg+pgN1,
	  pe=pe+peN1,
	  pp=pp+ppN1,
	  pj=pj+pjN
  where equipo=new.equipo_2;	  
else
  insert into resultados (equipo,puntos,pg,pe,pp,pj) values (new.equipo_2,puntosN,pgN,peN,ppN,pjN);
end if;


return NEW;
end
$$;
 #   DROP FUNCTION public.crpartidos();
       public          postgres    false            �            1255    24578    generarpartidos(integer, date)    FUNCTION       CREATE FUNCTION public.generarpartidos(partidos integer, fecha date) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare 
  cod1    integer;
  cod2    integer;
  cont    integer:= 0;
  cont1   integer:= 0;
  cont2   integer:= 0;
  ing     integer:=0;
  aux     integer:=0;
  
  rand    integer:=0;
  randc   integer:=0;
  rand1   integer:=0;
  randc1  integer:=0;
  vrand   varchar;
  vrand1  varchar;
  cas     varchar;
  auxi    varchar;
  
  nombre1 varchar;
  nombre2 varchar;
  fechain date;
  
  begin
	IF (partidos > 1)  THEN
	   IF EXISTS(SELECT nombre FROM equipos) THEN
	         select into cod1 count(nombre) from equipos;		 
             if (cod1*2>=partidos) then
			   cod2=112/partidos;
			   while(cont<cod1-1)
			   loop 
			      while(cont1<cod1-1)
				  loop
                      while(cont2<2)
					  loop
					    select nombre into nombre1 from equipos where id_equipo=cont+1;
						select nombre into nombre2 from equipos where id_equipo=cont1+2;
						
						rand:=(random () * (6 - 1 + 1))::int;
						rand1:=(random () * (6 - 1 + 1))::int;
						vrand:='';
                        vrand1:='';
						
						vrand:=CONCAT('{');
						while(randc<rand) loop
						   randc:=randc+1;
						   cas:=((random () * (30 - 1 + 1))::int)::varchar;
						   if(randc<rand) then
						     vrand:=CONCAT(vrand,'j',cas,',');
						   else
						     vrand:=CONCAT(vrand,'j',cas);
						   end if;
						end loop;
						vrand:=CONCAT(vrand,'}');randc:=0;
						  
						vrand1:=CONCAT('{');
                        while(randc1<rand1) loop
						  randc1:=randc1+1;
						  cas:=((random () * (30 - 1 + 1))::int)::varchar;
				          if(randc1<rand1) then
						     vrand1:=CONCAT(vrand1,'j',cas,',');
						   else
						     vrand1:=CONCAT(vrand1,'j',cas);
						   end if;
						end loop;
						vrand1:=CONCAT(vrand1,'}');randc1:=0;
						
					  	if(cont2=0 and aux<partidos and nombre1<>nombre2) then
						  ing:=cod2+ing; 
						  fecha:= fecha+interval '1day' * ing;
				          INSERT INTO partidos (equipo_1, equipo_2,marcador_e1,marcador_e2,jugador_1,jugador_2,fecha_partido) VALUES (nombre1, nombre2,rand,rand1,vrand,vrand1,fecha);
						  aux:=aux+1;
				   		end if;
				   		if(cont2=1 and aux<partidos and nombre1<>nombre2 ) then
				          ing:=cod2+ing; 
					      fecha:= fecha+interval '1day' * ing;
						  INSERT INTO partidos (equipo_2, equipo_1,marcador_e1,marcador_e2,jugador_1,jugador_2,fecha_partido) VALUES (nombre1, nombre2,rand,rand1,vrand,vrand1,fecha);
						   aux:=aux+1;
				   		end if;
						cont2:=cont2+1;
					  end loop;
					  cont2:=0;
				      cont1:=cont1+1;
				   end loop;
				   cont1:=0;
				   cont:=cont+1;
			   end loop;
			   return 1;
			 else
			    return -1;
			 end if;
	   else
	   		return -1;
	   end if;
	else
    	return -1;
	end if;
  end;
$$;
 D   DROP FUNCTION public.generarpartidos(partidos integer, fecha date);
       public          postgres    false            �            1255    16466 m   ingresarpartido(character varying, character varying, integer, integer, character varying, character varying)    FUNCTION     u  CREATE FUNCTION public.ingresarpartido(equipo1 character varying, equipo2 character varying, marcador1 integer, marcador2 integer, jugador1 character varying, jugador2 character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
	cod integer;
	fecha date;
begin
	if exists(SELECT equipo_1,equipo_2,fecha_partido FROM partidos WHERE (fecha_partido = current_date) and (equipo_1=equipo1) and (equipo_2=equipo2) ) then
		return -1;
	else 
	    if exists(SELECT equipo_1,equipo_2,fecha_partido FROM partidos WHERE  (equipo_1=equipo2) and (fecha_partido = current_date) and (equipo_2=equipo1) ) then
		 	 return -1;
		else
             if exists(SELECT equipo_1,equipo_2 FROM partidos WHERE  ((equipo_1=equipo1) and (equipo_2=equipo2)) or ((equipo_1=equipo2) and (equipo_2=equipo1)) ) then
			    if exists(SELECT equipo_1,equipo_2 FROM partidos WHERE  ((equipo_1=equipo1) and (equipo_2=equipo2)) ) then
				   select  fecha_partido into fecha from partidos WHERE ((equipo_1=equipo1) and (equipo_2=equipo2)) ORDER BY fecha_partido DESC limit 1;
				   if((fecha+interval'6 month')<=current_date) then
                      	    insert into partidos (equipo_1 , equipo_2 , marcador_E1 , marcador_E2 , jugador_1 , jugador_2 , fecha_partido ) 
		     	 			values (equipo1,equipo2,marcador1,marcador2,jugador1,jugador2,current_date);
					  return 1;
				   end if;
				   return 0;
				 else
				   select  fecha_partido into fecha from partidos WHERE ((equipo_1=equipo2) and (equipo_2=equipo1)) ORDER BY fecha_partido DESC limit 1;
				   if((fecha+interval'6 month')<=current_date) then
                      	    insert into partidos (equipo_1 , equipo_2 , marcador_E1 , marcador_E2 , jugador_1 , jugador_2 , fecha_partido ) 
		     	 			values (equipo1,equipo2,marcador1,marcador2,jugador1,jugador2,current_date);
					  return 1;
				   end if;
				   return 0;				    
				 end if; 
			 else
			     insert into partidos (equipo_1 , equipo_2 , marcador_E1 , marcador_E2 , jugador_1 , jugador_2 , fecha_partido ) 
		     	 values (equipo1,equipo2,marcador1,marcador2,jugador1,jugador2,current_date);
				 return 1;
			 end if;
		end if;
	end if;
end;
$$;
 �   DROP FUNCTION public.ingresarpartido(equipo1 character varying, equipo2 character varying, marcador1 integer, marcador2 integer, jugador1 character varying, jugador2 character varying);
       public          postgres    false            �            1259    16396    equipos    TABLE     b   CREATE TABLE public.equipos (
    id_equipo integer NOT NULL,
    nombre character varying(50)
);
    DROP TABLE public.equipos;
       public         heap    postgres    false            �            1259    16394    equipos_id_equipo_seq    SEQUENCE     �   CREATE SEQUENCE public.equipos_id_equipo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.equipos_id_equipo_seq;
       public          postgres    false    203            "           0    0    equipos_id_equipo_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.equipos_id_equipo_seq OWNED BY public.equipos.id_equipo;
          public          postgres    false    202            �            1259    16469    partidos    TABLE       CREATE TABLE public.partidos (
    id_equipo integer NOT NULL,
    equipo_1 character varying(50),
    equipo_2 character varying(50),
    marcador_e1 integer,
    marcador_e2 integer,
    jugador_1 character varying(50),
    jugador_2 character varying(50),
    fecha_partido date
);
    DROP TABLE public.partidos;
       public         heap    postgres    false            �            1259    16467    partidos_id_equipo_seq    SEQUENCE     �   CREATE SEQUENCE public.partidos_id_equipo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.partidos_id_equipo_seq;
       public          postgres    false    207            #           0    0    partidos_id_equipo_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.partidos_id_equipo_seq OWNED BY public.partidos.id_equipo;
          public          postgres    false    206            �            1259    16442 
   resultados    TABLE     �   CREATE TABLE public.resultados (
    id_equipo integer NOT NULL,
    equipo character varying(50),
    puntos integer,
    pg integer,
    pe integer,
    pp integer,
    pj integer
);
    DROP TABLE public.resultados;
       public         heap    postgres    false            �            1259    16440    resultados_id_equipo_seq    SEQUENCE     �   CREATE SEQUENCE public.resultados_id_equipo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.resultados_id_equipo_seq;
       public          postgres    false    205            $           0    0    resultados_id_equipo_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.resultados_id_equipo_seq OWNED BY public.resultados.id_equipo;
          public          postgres    false    204            �
           2604    16399    equipos id_equipo    DEFAULT     v   ALTER TABLE ONLY public.equipos ALTER COLUMN id_equipo SET DEFAULT nextval('public.equipos_id_equipo_seq'::regclass);
 @   ALTER TABLE public.equipos ALTER COLUMN id_equipo DROP DEFAULT;
       public          postgres    false    203    202    203            �
           2604    16472    partidos id_equipo    DEFAULT     x   ALTER TABLE ONLY public.partidos ALTER COLUMN id_equipo SET DEFAULT nextval('public.partidos_id_equipo_seq'::regclass);
 A   ALTER TABLE public.partidos ALTER COLUMN id_equipo DROP DEFAULT;
       public          postgres    false    207    206    207            �
           2604    16445    resultados id_equipo    DEFAULT     |   ALTER TABLE ONLY public.resultados ALTER COLUMN id_equipo SET DEFAULT nextval('public.resultados_id_equipo_seq'::regclass);
 C   ALTER TABLE public.resultados ALTER COLUMN id_equipo DROP DEFAULT;
       public          postgres    false    205    204    205                      0    16396    equipos 
   TABLE DATA           4   COPY public.equipos (id_equipo, nombre) FROM stdin;
    public          postgres    false    203    9                 0    16469    partidos 
   TABLE DATA           �   COPY public.partidos (id_equipo, equipo_1, equipo_2, marcador_e1, marcador_e2, jugador_1, jugador_2, fecha_partido) FROM stdin;
    public          postgres    false    207   )9                 0    16442 
   resultados 
   TABLE DATA           O   COPY public.resultados (id_equipo, equipo, puntos, pg, pe, pp, pj) FROM stdin;
    public          postgres    false    205   �9       %           0    0    equipos_id_equipo_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.equipos_id_equipo_seq', 3, true);
          public          postgres    false    202            &           0    0    partidos_id_equipo_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.partidos_id_equipo_seq', 1993, true);
          public          postgres    false    206            '           0    0    resultados_id_equipo_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.resultados_id_equipo_seq', 12, true);
          public          postgres    false    204            �
           2606    16401    equipos equipos_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.equipos
    ADD CONSTRAINT equipos_pkey PRIMARY KEY (id_equipo);
 >   ALTER TABLE ONLY public.equipos DROP CONSTRAINT equipos_pkey;
       public            postgres    false    203            �
           2606    16474    partidos partidos_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.partidos
    ADD CONSTRAINT partidos_pkey PRIMARY KEY (id_equipo);
 @   ALTER TABLE ONLY public.partidos DROP CONSTRAINT partidos_pkey;
       public            postgres    false    207            �
           2606    16447    resultados resultados_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.resultados
    ADD CONSTRAINT resultados_pkey PRIMARY KEY (id_equipo);
 D   ALTER TABLE ONLY public.resultados DROP CONSTRAINT resultados_pkey;
       public            postgres    false    205            �
           2620    24596    partidos cr_insert    TRIGGER     m   CREATE TRIGGER cr_insert BEFORE INSERT ON public.partidos FOR EACH ROW EXECUTE FUNCTION public.crpartidos();
 +   DROP TRIGGER cr_insert ON public.partidos;
       public          postgres    false    207    222                  x�3�4�2�4�2�4����� A         g   x�5��� �o�EԖ]:�+w/Ԙ@H�=�$T��\4�j���ER�hf��5��C,D�퐖�QJ�{�)Q���N�z�ƾl�����}#�         -   x���	 0���=L��4���p?	ՊbJh6�6Q����~��
     