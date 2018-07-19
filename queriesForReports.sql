USE proyFinal;

/*Display EHR for a patient*/
select id_paciente, CONCAT(nombre, " ", apellido) as 'Nombre completo', direccion, 
		telefono, ciudad, estadoCivil, religion, ocupacion, fecha_de_nacimiento
from paciente;

select tipo_de_sangre, nombre_alergia as 'alergias'
from paciente p
join informacion_medica_paciente imp on p.id_paciente = imp.id_paciente
join catalogo_alergias ca on p.id_paciente = ca.id_paciente;

select c.id_consulta, c.fecha, d.nombre as 'nombre doctor', floor(datediff(curdate(), p.fecha_de_nacimiento)/365) as 'edad paciente', 
		c.motivo, c.nota_clinica, c.id_receta_medica
from consulta c
join paciente p on c.id_paciente = p.id_paciente
join doctor d on c.id_doctor = d.id_doctor
join receta_medica rm on c.id_receta_medica = rm.id_receta_medica
order by c.fecha desc;


select p.id_prueba, ip.fecha, p.descripcion as 'nombre prueba', ip.total
from paciente pac
join consulta c on pac.id_paciente = c.id_paciente
join instancia_prueba ip on c.id_instancia_prueba = ip.id_instancia_prueba
join prueba p on ip.id_prueba = p.id_prueba
order by ip.fecha desc;

/*Delete EHR*/
/*
begin
start transaction;

delete
	from diagnostico
    where id_consulta in (
        select id_consulta
        from consulta 
        where id_paciente = getID
    );
delete
	from respuesta_prueba 
    where id_instancia_prueba in (
    	select id_instancia_prueba
        from instancia_prueba
        where id_instancia_prueba in(
        	select id_instancia_prueba
        	from consulta 
        	where id_paciente = getID
        )
);
delete
	from detalle_receta 
    where id_receta_medica in (
        select id_receta_medica
        from receta_medica
        where id_receta_medica in (
            select id_receta_medica
            from consulta 
            where id_paciente = getID
        )
	);
delete
	from receta_medica 
    where id_receta_medica in (
    	select id_receta_medica
        from consulta 
        where id_paciente = getID
	);    
delete
	from consulta 
    where id_paciente = getID;
delete
	from instancia_prueba 
    where id_instancia_prueba in (
    	select id_instancia_prueba
        from consulta 
        where id_paciente = getID
	);
delete s
	from paciente
    where id_paciente = getID;
commit;
end	
commit;
end
*/

/*Hamilton Anxiety Report*/
select ip.fecha, CONCAT(pac.nombre, " ", pac.apellido) as 'nombre completo', d.nombre, ip.total
from paciente pac
join consulta c on c.id_paciente = pac.id_paciente
join doctor d on c.id_doctor = d.id_doctor
join instancia_prueba ip on c.id_instancia_prueba = ip.id_instancia_prueba;

select pp.texto_pregunta, pp.ayuda_pregunta, rp.valor
from instancia_prueba ip 
join respuesta_prueba rp on rp.id_instancia_prueba = ip.id_instancia_prueba
join pregunta_prueba pp on rp.id_pregunta_prueba = pp.id_pregunta_prueba;


/*Diagnosis report*/

select ds.id_dsm5, ds.dsm5_descripcion, count(ds.id_dsm5) as'numero de diagnósticos'
from diagnostico d
join dsm5 ds on ds.id_dsm5 = d.id_dsm5
group by ds.id_dsm5
order by count(ds.id_dsm5) desc;

/*Diagnosis for a patient given last name*/
select CONCAT(p.nombre, " ", p.apellido) as 'nombre completo', floor(datediff(curdate(), p.fecha_de_nacimiento)/365) as 'edad', 
c.fecha, ds.dsm5_descripcion
from paciente p
join consulta c on p.id_paciente = c.id_paciente
join diagnostico d on c.id_consulta = d.id_consulta 
join dsm5 ds on d.id_dsm5 = ds.id_dsm5
order by c.fecha desc;

/*Visits Count*/
select CONCAT(p.nombre, " ", p.apellido) as 'nombre completo', count(c.id_paciente) as 'numero de visitas'
from paciente p
join consulta c on c.id_paciente = p.id_paciente
group by c.id_paciente
order by p.nombre, p.apellido;
/* Prescription Details*/
select c.fecha, CONCAT(p.nombre, " ", p.apellido) as 'nombre del paciente', d.nombre as 'nombre del doctor',
		m.nombre as 'nombre de medicina', dr.instrucciones, dr.dias, dr.frecuencia, dr.dosis
from paciente p
join consulta c on c.id_paciente = p.id_paciente
join doctor d on d.id_doctor = c.id_doctor
join receta_medica rm on c.id_receta_medica = rm.id_receta_medica
join detalle_receta dr on rm.id_receta_medica = dr.id_receta_medica
join medicamento m on dr.id_medicamento = m.id_medicamento;
