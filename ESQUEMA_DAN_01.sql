-- SEQ CC
create sequence seq_cc_medio_pago_id start 1 increment 50;
create sequence seq_cc_pago_id start 1 increment 50;
-- SEQ USR
create sequence seq_usr_cliente_id start 1 increment 50;
create sequence seq_usr_empleado_id start 1 increment 50;
create sequence seq_usr_obra_id start 1 increment 50;
create sequence seq_usr_tipo_obra_id start 1 increment 50;
create sequence seq_usr_usuario_id start 1 increment 50;
-- SEQ PRD
create sequence seq_prd_detalle_provision_id start 1 increment 50;
create sequence seq_prd_movimiento_stock_id start 1 increment 50;
create sequence seq_prd_orden_provision_id start 1 increment 50;
create sequence seq_prd_producto_id start 1 increment 50;
create sequence seq_prd_unidad_id start 1 increment 50;
-- SEQ PED
create sequence seq_pedido_detalle_id start 1 increment 50;
create sequence seq_pedido_id start 1 increment 50;
create sequence seq_producto_id start 1 increment 50;

-- TBL CC
create table cc_medio_pago (tipo_medio_pago int4 not null, id int4 not null, observacion varchar(255), banco varchar(255), fecha_cobro TIME, nro_cheque int4, nro_recibo int4, cbu_destino varchar(255), cbu_origen varchar(255), codigo_transferencia int8, primary key (id));
create table cc_pago (id int4 not null, fecha_pago TIME, cliente_id int4, medio_pago_id int4, primary key (id));
-- TBL USR
create table usr_cliente (id int4 not null, cuit varchar(255), habilitado_online boolean, mail varchar(255), max_cuenta_corriente float8, razon_social varchar(255), usuario_id int4, user_id int4, primary key (id));
create table usr_cliente_obras (cliente_id int4 not null, obras_id int4 not null);
create table usr_obra (id int4 not null, descripcion varchar(255), direccion varchar(255), latitud float4, longitud float4, superficie int4, cliente_id int4, tipo_obra_id int4, primary key (id));
create table usr_tipo_obra (id int4 not null, descripcion varchar(255), primary key (id));
create table usr_tipo_usuario (id int4 not null, tipo varchar(255), primary key (id));
create table usr_usuario (id int4 not null, password varchar(255), username varchar(255), tipo_usuario_id int4, primary key (id));
-- TBL PRD
create table prd_detalle_provision (id int4 not null, cantidad int4, producto_id int4, orden_provision_id int4, primary key (id));
create table prd_movimiento_stock (id int4 not null, cantidad_entrada int4, cantidad_salida int4, fecha_movimiento timestamp, detalle_pedido_id int4, detalle_provision_id int4, producto_id int4, primary key (id));
create table prd_orden_provision (id int4 not null, fecha_provision TIME, primary key (id));
create table prd_producto (id int4 not null, descripcion varchar(255), nombre varchar(255), precio float8, stock_actual int4, stock_minimo int4, unidad_id int4, primary key (id));
create table prd_unidad (id_unidad int4 not null, descripcion varchar(255), primary key (id_unidad));
-- TBL PED
create table ped_estado_pedido (id int4 not null, estado varchar(255), primary key (id));
create table ped_pedido (id int4 not null, fecha_pedido TIME, estado_pedido_id int4, obra_id int4, primary key (id));
create table ped_pedido_detalle (id int4 not null, cantidad int4, precio float8, detalle_pedido_id int4, producto_id int4, primary key (id));
create table ped_producto (id int4 not null, descripcion varchar(255), precio float8, primary key (id));
-- FK CC
alter table cc_pago add constraint FK950g2djoybu6gbhablykcycdy foreign key (cliente_id) references usr_cliente;
alter table cc_pago add constraint FKgan823arru9frmgsjh80jnnjx foreign key (medio_pago_id) references cc_medio_pago;
-- FK USR
alter table usr_cliente_obras add constraint UK_rsm2quh0dy122ypfmno8q8inh unique (obras_id);
alter table usr_cliente add constraint FK1prs2atsyqvi8i1qae4kn79to foreign key (usuario_id) references usr_usuario;
alter table usr_cliente add constraint FKee3gumsbmm262g7w4sta6pahv foreign key (user_id) references usr_usuario;
alter table usr_cliente_obras add constraint FKhrmvvh54mggov10woewomadd9 foreign key (obras_id) references usr_obra;
alter table usr_cliente_obras add constraint FKdv3vq37ma30nq5q0xlrolryqf foreign key (cliente_id) references usr_cliente;
alter table usr_obra add constraint FKmi1wih9lwqudr62drc2r1gx2d foreign key (cliente_id) references usr_cliente;
alter table usr_obra add constraint FKndti3881q59t86b262ta1qbmt foreign key (tipo_obra_id) references usr_tipo_obra;
alter table usr_usuario add constraint FKsfg0f2vfondte1ku5it8c9pr foreign key (tipo_usuario_id) references usr_tipo_usuario;

-- FK PRD
alter table prd_detalle_provision add constraint FK2yrvi72wbtw8ys37y3t483kbg foreign key (producto_id) references prd_producto;
alter table prd_detalle_provision add constraint FKg6avdu4xk6c9utdlhs9iglsg1 foreign key (orden_provision_id) references prd_orden_provision;
alter table prd_movimiento_stock add constraint FK5ajg3y2fldnxnohcxyfwr9ajl foreign key (detalle_pedido_id) references ped_detalle_pedido;
alter table prd_movimiento_stock add constraint FKmlc7bkfb3ov6jlereg3wjddt6 foreign key (detalle_provision_id) references prd_detalle_provision;
alter table prd_movimiento_stock add constraint FK2afx37wt2pkds7ql58eyvwvrm foreign key (producto_id) references prd_producto;
alter table prd_producto add constraint FK8naogdmr86f9q3veco7rqcstv foreign key (unidad_id) references prd_unidad;
-- FK PED
alter table ped_pedido add constraint FKcehprhhsa9cxq9a4uo7cnongb foreign key (estado_pedido_id) references ped_estado_pedido;
alter table ped_pedido add constraint FKd22v73s0y6wkuk7jfocfia373 foreign key (obra_id) references usr_obra;
alter table ped_pedido_detalle add constraint FK1xm31m4himi942djyubhjshj8 foreign key (detalle_pedido_id) references ped_pedido;
alter table ped_pedido_detalle add constraint FK6q1jm3bkvh92c6c2hyanc4nad foreign key (producto_id) references ped_producto;
