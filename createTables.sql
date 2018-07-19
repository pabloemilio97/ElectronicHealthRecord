USE proyFinal;
DROP TABLE if exists diagnostico;
DROP TABLE if exists dsm5;
DROP TABLE if exists consulta;
DROP TABLE if exists detalle_receta;
DROP TABLE if exists receta_medica;
DROP TABLE if exists medicamento;
DROP TABLE if exists respuesta_prueba;
DROP TABLE if exists pregunta_prueba;
DROP TABLE if exists instancia_prueba;
DROP TABLE if exists prueba;
DROP TABLE if exists doctor;
DROP TABLE if exists informacion_medica_paciente;
DROP TABLE if exists catalogo_alergias;
DROP TABLE if exists paciente;

CREATE TABLE doctor(
    id_doctor int,
    nombre varchar(256),
    PRIMARY KEY (id_doctor)
);

CREATE TABLE prueba(
    id_prueba int,
    descripcion text,
    PRIMARY KEY (id_prueba)
);

CREATE TABLE instancia_prueba(
    id_instancia_prueba int,
    id_prueba int,
    fecha date,
    total int,
    PRIMARY KEY(id_instancia_prueba),
    FOREIGN KEY(id_prueba) REFERENCES prueba(id_prueba)
);

CREATE TABLE pregunta_prueba(
    id_pregunta_prueba int,
    id_prueba int,
    numero_pregunta int,
    texto_pregunta text,
    ayuda_pregunta text,
    PRIMARY KEY (id_pregunta_prueba),
    FOREIGN KEY (id_prueba) REFERENCES prueba(id_prueba)
);

CREATE TABLE respuesta_prueba(
    id_respuesta_prueba int,
    id_instancia_prueba int,
    id_pregunta_prueba int,
    valor int,
    PRIMARY KEY (id_respuesta_prueba),
    FOREIGN KEY (id_instancia_prueba) REFERENCES instancia_prueba(id_instancia_prueba),
    FOREIGN KEY (id_pregunta_prueba) REFERENCES pregunta_prueba(id_pregunta_prueba)
);

CREATE TABLE paciente(
    id_paciente int, 
    nombre varchar(256),
    apellido varchar(256),
    direccion text,
    telefono text,
    ciudad text,
    estadoCivil text,
    religion text,
    ocupacion text,
    fecha_de_nacimiento date,
    PRIMARY KEY (id_paciente)
);

CREATE TABLE informacion_medica_paciente(
    id_informacion_medica_paciente int,
    id_paciente int,
    tipo_de_sangre varchar(256),
    fuma bool,
    tiene_problema_alcohol bool,
    PRIMARY KEY(id_informacion_medica_paciente),
    FOREIGN KEY(id_paciente) references paciente(id_paciente)
);

CREATE TABLE catalogo_alergias(
    id_catalogo_alergias int,
    id_paciente int,
    nombre_alergia varchar(256),
    PRIMARY KEY(id_catalogo_alergias),
    FOREIGN KEY(id_paciente) references paciente(id_paciente)
);

CREATE TABLE receta_medica(
    id_receta_medica int,
    PRIMARY KEY (id_receta_medica)
);

CREATE TABLE medicamento(
    id_medicamento int,
    nombre varchar(256),
    ingrediente_activo varchar(256),
    laboratorio varchar(256),
    presentacion varchar(256),
    PRIMARY KEY (id_medicamento)
);

CREATE TABLE detalle_receta(
    id_receta_medica int,
    id_medicamento int,
    instrucciones text,
    dias int,
    frecuencia int,
    dosis varchar(256),
    FOREIGN KEY (id_receta_medica) REFERENCES receta_medica(id_receta_medica),
    FOREIGN KEY (id_medicamento) REFERENCES medicamento(id_medicamento)
);

CREATE TABLE consulta(
    id_consulta int,
    id_doctor int,
    id_instancia_prueba int,
    id_paciente int,
    id_receta_medica int,
    fecha date,
    hora varchar(256),
    nota_clinica text,
    motivo text,
    estatura float,
    peso float,
    PRIMARY KEY (id_consulta),
    FOREIGN KEY(id_doctor) REFERENCES doctor(id_doctor),
    FOREIGN KEY(id_instancia_prueba) REFERENCES instancia_prueba(id_instancia_prueba),
    FOREIGN KEY(id_paciente) REFERENCES paciente(id_paciente),
    FOREIGN KEY(id_receta_medica) REFERENCES receta_medica(id_receta_medica)
);

CREATE TABLE dsm5(
    id_dsm5 int,
    icd9 varchar(256),
    icd10 varchar(256),
    dsm5_descripcion text,
    PRIMARY KEY (id_dsm5)
);

CREATE TABLE diagnostico(
    id_dsm5 int,
    id_consulta int,
    FOREIGN KEY (id_dsm5) REFERENCES dsm5(id_dsm5),
    FOREIGN KEY (id_consulta) REFERENCES consulta(id_consulta)
);

INSERT INTO doctor(id_doctor, nombre)
VALUES (1, 'Juan');

INSERT INTO prueba(id_prueba, descripcion)
VALUES (1, 'test ansiedad'),
(2, 'test depresion');

INSERT INTO instancia_prueba(id_instancia_prueba, id_prueba, fecha, total)
VALUES (1, 1, '2018-01-01', null), #paciente1
(2,1,'2018-01-02', null),
(3,1,'2018-01-03', null),
(4,1,'2018-01-04', null),
(5,1,'2018-01-05', null),
(6,2,'2018-01-06',null),
(7,2,'2018-01-07',null),
(8,2,'2018-01-08',null),
(9,2,'2018-01-09',null),
(10,2,'2018-01-10',null),

#paciente2
(11, 1, '2018-02-01', null),
(12,1,'2018-02-02', null),
(13,1,'2018-02-03', null),
(14,1,'2018-02-04', null),
(15,1,'2018-02-05', null),
(16,2,'2018-02-06',null),
(17,2,'2018-02-07',null),
(18,2,'2018-02-08',null),
(19,2,'2018-02-09',null),
(20,2,'2018-02-10',null),
#paciente3
(21, 1, '2018-03-01', null),
(22,1,'2018-03-02', null),
(23,1,'2018-03-03', null),
(24,1,'2018-03-04', null),
(25,1,'2018-03-05', null),
(26,2,'2018-03-06',null),
(27,2,'2018-03-07',null),
(28,2,'2018-03-08',null),
(29,2,'2018-03-09',null),
(30,2,'2018-03-10',null),
#paciente 4
(31, 1, '2018-04-01', null),
(32,1,'2018-04-02', null),
(33,1,'2018-04-03', null),
(34,1,'2018-04-04', null),
(35,1,'2018-04-05', null),
(36,2,'2018-04-06',null),
(37,2,'2018-04-07',null),
(38,2,'2018-04-08',null),
(39,2,'2018-04-09',null),
(40,2,'2018-04-10',null),
#paciente 5
(41, 1, '2018-05-01', null),
(42,1,'2018-05-02', null),
(43,1,'2018-05-03', null),
(44,1,'2018-05-04', null),
(45,1,'2018-05-05', null),
(46,2,'2018-05-06',null),
(47,2,'2018-05-07',null),
(48,2,'2018-05-08',null),
(49,2,'2018-05-09',null),
(50,2,'2018-05-10',null);

INSERT INTO pregunta_prueba(id_pregunta_prueba, id_prueba, numero_pregunta, texto_pregunta, ayuda_pregunta)
VALUES (1, 1, 1, 'Estado ansioso', 'Preocupaciones, temor de que suceda lo peor, temor anticipado, irritabilidad.'),
(2,1,2,'Tensión', 'Sensaciones de tensión, fatigabilidad, sobresalto al responder, llanto fácil, temblores, sensación de inquietud, imposibilidad de relajarse.'),
(3,1,3, 'Temores','A la oscuridad, a los desconocidos, a ser dejado solo, a los animales, al tráfico, a las multitudes.'),
(4,1,4, 'Insomnio','Dificultad para conciliar el sueño. Sueño interrumpido, sueño insatisfactorio y sensación de fatiga al despertar, pesadillas, terrores nocturnos.'),
(5,1,5, 'Funciones intelectuales (Cognitivas)','Dificultad de concentración, mala o escasa memoria.'),
(6,1,6, 'Humor depresivo',' Pérdida de interés. Falta de placer en los pasatiempos, depresión, despertarse más temprano de lo esperado. Variaciones anímicas a lo largo del día.'),
(7,1,7, 'Síntomas somáticos musculares','Dolores musculares, espasmos musculares o calambres, rigidez muscular, tics, rechinar de dientes, voz vacilante, tono muscular aumentado.'),
(8,1,8,'Síntomas somáticos sensoriales','Zumbido de oídos, visión borrosa, oleadas de frío y calor,  sensación de debilidad. Sensaciones parestésicas (pinchazos, picazón u hormigueos).'),
(9,1,9, 'Síntomas cardiovasculares','Taquicardia, palpitaciones, dolor precordial (en el pecho), pulsaciones vasculares pronunciadas, sensacion de "baja presión" o desmayo, arritmias.'),
(10,1,10, 'Síntomas respiratorios','Opresión o constricción en el tórax (pecho), sensación de ahogo, suspiros, disnea (sensación de falta de aire o de dificultad respiratoria).'),
(11,1,11, 'Síntomas gastrointestinales','Dificultades al deglutir, flatulencia, dolor abdominal, sensación de ardor, pesadez abdominal, nauseas, vómitos, borborismos, heces blandas, pérdida de peso, constipación.'),
(12,1,12, 'Sintomas genitourinarios','Micciones frecuentes, micción urgente, amenorrea (falta del período menstrual), menorragia, frigidez, eyaculación precoz, pérdida de libido, impotencia sexual.'),
(13,1,13,'Síntomas del sistema nervioso autónomo',' Boca seca, accesos de enrojecimiento, palidez, tendencia a la sudoración, vértigos, cefaleas (dolor de cabeza) por tensión, erectismo piloso (piel de gallina).'),
(14,1,14, 'Conducta en el transcurso del test','Inquietud, impaciencia o intranquilidad, temblor de manos, fruncimiento del entrecejo, rostro preocupado, suspiros o respiración rápida, palidez facial, deglución de saliva, eructos, tics.'),
(15,2,1, 'Humor deprimido, tristeza (melancolía), desesperanza, desamparo, inutilidad',''),
(16,2,2, 'Sentimiento de culpa',''),
(17,2,3,'Suicidio',''),
(18,2,4,'Insomnio precoz',''),
(19,2,5,'Insomnio intermedio',''),
(20,2,6,'Insomnio tardío',''),
(21,2,7,'Trabajo y actividades',''),
(22,2,8, 'Inhibición psicomotora',' (Lentitud de pensamiento y palabra, facultad de concentración disminuida, disminución de la actividad motora)'),
(23,2,9,'Agitación psicomotora',''),
(24,2,10,'Ansiedad psíquica',''),
(25,2,11,'Ansiedad somática','(Signos físicos concomitantes de ansiedad tales como: Gastrointestinales: sequedad de boca, diarrea, eructos, etc. Cardiovasculares: palpitaciones, cefaleas. Respiratorios: hiperventilación, suspiros. Frecuencia de micción incrementada. Transpiración)'),
(26,2,12,'Síntomas somáticos gastrointestinales',''),
(27,2,13,'Síntomas somáticos generales',''),
(28,2,14,'Síntomas genitales','(Disminución de la libido y trastornos menstruales)'),
(29,2,15,'Hipocondría',''),
(30,2,16,'Pérdida de peso',''),
(31,2,17,'Perspicacia','');

/*
de 0 a 17 leve severidad de ansiedad
de 18 a 24 leve a moderada severidad de ansiedad
de 25 a 30 severidad  de moderada a severa
+30 muy severa
*/
INSERT INTO respuesta_prueba(id_respuesta_prueba, id_instancia_prueba, id_pregunta_prueba, valor)
VALUES (1, 1, 1, 4), 
(2, 1, 2, 2),
(3, 1, 3, 3),
(4, 1, 4, 2),
(5, 1, 5, 3),
(6, 1, 6, 2),
(7, 1, 7, 2),
(8, 1, 8, 2),
(9, 1, 9, 2),
(10, 1, 10, 2),
(11, 1, 11, 3),
(12, 1, 12, 2),
(13, 1, 13, 2),
(14, 1, 14, 4),
(15, 2, 1, 3),
(16, 2, 2, 2),
(17, 2, 3, 3),
(18, 2, 4, 2),
(19, 2, 5, 3),
(20, 2, 6, 2),
(21, 2, 7, 2),
(22, 2, 8, 2),
(23, 2, 9, 2),
(24, 2, 10, 2),
(25, 2, 11, 3),
(26, 2, 12, 2),
(27, 2, 13, 2),
(28, 2, 14, 4),
(29, 3, 1, 3),
(30, 3, 2, 2),
(31, 3, 3, 3),
(32, 3, 4, 2),
(33, 3, 5, 3),
(34, 3, 6, 2),
(35, 3, 7, 2),
(36, 3, 8, 2),
(37, 3, 9, 2),
(38, 3, 10, 2),
(39, 3, 11, 2),
(40, 3, 12, 2),
(41, 3, 13, 2),
(42, 3, 14, 4),
(43, 4, 1, 4),
(44, 4, 2, 2),
(45, 4, 3, 1),
(46, 4, 4, 2),
(47, 4, 5, 1),
(48, 4, 6, 2),
(49, 4, 7, 2),
(50, 4, 8, 2),
(51, 4, 9, 2),
(52, 4, 10, 2),
(53, 4, 11, 3),
(54, 4, 12, 2),
(55, 4, 13, 2),
(56, 4, 14, 4),
(57, 5, 1, 1),
(58, 5, 2, 2),
(59, 5, 3, 3),
(60, 5, 4, 2),
(61, 5, 5, 3),
(62, 5, 6, 2),
(63, 5, 7, 2),
(64, 5, 8, 2),
(65, 5, 9, 2),
(66, 5, 10, 2),
(67, 5, 11, 2),
(68, 5, 12, 2),
(69, 5, 13, 2),
(70, 5, 14, 2),
(71, 6, 1, null),
(72, 6, 2, null),
(73, 6, 3, null),
(74, 6, 4, null),
(75, 6, 5, null),
(76, 6, 6, null),
(77, 6, 7, null),
(78, 6, 8, null),
(79, 6, 9, null),
(80, 6, 10, null),
(81, 6, 11, null),
(82, 6, 12, null),
(83, 6, 13, null),
(84, 6, 14, null),
(85, 7, 1, null),
(86, 7, 2, null),
(87, 7, 3, null),
(88, 7, 4, null),
(89, 7, 5, null),
(90, 7, 6, null),
(91, 7, 7, null),
(92, 7, 8, null),
(93, 7, 9, null),
(94, 7, 10, null),
(95, 7, 11, null),
(96, 7, 12, null),
(97, 7, 13, null),
(98, 7, 14, null),
(99, 8, 1, null),
(100, 8, 2, null),
(101, 8, 3, null),
(102, 8, 4, null),
(103, 8, 5, null),
(104, 8, 6, null),
(105, 8, 7, null),
(106, 8, 8, null),
(107, 8, 9, null),
(108, 8, 10, null),
(109, 8, 11, null),
(110, 8, 12, null),
(111, 8, 13, null),
(112, 8, 14, null),
(113, 9, 1, null),
(114, 9, 2, null),
(115, 9, 3, null),
(116, 9, 4, null),
(117, 9, 5, null),
(118, 9, 6, null),
(119, 9, 7, null),
(120, 9, 8, null),
(121, 9, 9, null),
(122, 9, 10, null),
(123, 9, 11, null),
(124, 9, 12, null),
(125, 9, 13, null),
(126, 9, 14, null),
(127, 10, 1, null),
(128, 10, 2, null),
(129, 10, 3, null),
(130, 10, 4, null),
(131, 10, 5, null),
(132, 10, 6, null),
(133, 10, 7, null),
(134, 10, 8, null),
(135, 10, 9, null),
(136, 10, 10, null),
(137, 10, 11, null),
(138, 10, 12, null),
(139, 10, 13, null),
(140, 10, 14, null),

#paciente 2

(141, 11, 1, 4), 
(142, 11, 2, 2),
(143, 11, 3, 3),
(144, 11, 4, 2),
(145, 11, 5, 3),
(146, 11, 6, 2),
(147, 11, 7, 2),
(148, 11, 8, 2),
(149, 11, 9, 2),
(150, 11, 10, 2),
(151, 11, 11, 3),
(152, 11, 12, 2),
(153, 11, 13, 2),
(154, 11, 14, 4),
(155, 12, 1, 3),
(156, 12, 2, 2),
(157, 12, 3, 3),
(158, 12, 4, 2),
(159, 12, 5, 3),
(160, 12, 6, 2),
(161, 12, 7, 2),
(162, 12, 8, 2),
(163, 12, 9, 2),
(164, 12, 10, 2),
(165, 12, 11, 3),
(166, 12, 12, 2),
(167, 12, 13, 2),
(168, 12, 14, 4),
(169, 13, 1, 3),
(170, 13, 2, 2),
(171, 13, 3, 3),
(172, 13, 4, 2),
(173, 13, 5, 3),
(174, 13, 6, 2),
(175, 13, 7, 2),
(176, 13, 8, 2),
(177, 13, 9, 2),
(178, 13, 10, 2),
(179, 13, 11, 2),
(180, 13, 12, 2),
(181, 13, 13, 2),
(182, 13, 14, 3),
(183, 14, 1, 1),
(184, 14, 2, 2),
(185, 14, 3, 3),
(186, 14, 4, 2),
(187, 14, 5, 1),
(188, 14, 6, 2),
(189, 14, 7, 2),
(190, 14, 8, 2),
(191, 14, 9, 2),
(192, 14, 10, 2),
(193, 14, 11, 3),
(194, 14, 12, 1),
(195, 14, 13, 2),
(196, 14, 14, 3),
(197, 15, 1, 1),
(198, 15, 2, 1),
(199, 15, 3, 3),
(200, 15, 4, 2),
(201, 15, 5, 3),
(202, 15, 6, 2),
(203, 15, 7, 4),
(204, 15, 8, 2),
(205, 15, 9, 2),
(206, 15, 10, 1),
(207, 15, 11, 2),
(208, 15, 12, 1),
(209, 15, 13, 2),
(210, 15, 14, 1),
(211, 16, 1, null),
(212, 16, 2, null),
(213, 16, 3, null),
(214, 16, 4, null),
(215, 16, 5, null),
(216, 16, 6, null),
(217, 16, 7, null),
(218, 16, 8, null),
(219, 16, 9, null),
(220, 16, 10, null),
(221, 16, 11, null),
(222, 16, 12, null),
(223, 16, 13, null),
(224, 16, 14, null),
(225, 17, 1, null),
(226, 17, 2, null),
(227, 17, 3, null),
(228, 17, 4, null),
(229, 17, 5, null),
(230, 17, 6, null),
(231, 17, 7, null),
(232, 17, 8, null),
(233, 17, 9, null),
(234, 17, 10, null),
(235, 17, 11, null),
(236, 17, 12, null),
(237, 17, 13, null),
(238, 17, 14, null),
(239, 18, 1, null),
(240, 18, 2, null),
(241, 18, 3, null),
(242, 18, 4, null),
(243, 18, 5, null),
(244, 18, 6, null),
(245, 18, 7, null),
(246, 18, 8, null),
(247, 18, 9, null),
(248, 18, 10, null),
(249, 18, 11, null),
(250, 18, 12, null),
(251, 18, 13, null),
(252, 18, 14, null),
(253, 19, 1, null),
(254, 19, 2, null),
(255, 19, 3, null),
(256, 19, 4, null),
(257, 19, 5, null),
(258, 19, 6, null),
(259, 19, 7, null),
(260, 19, 8, null),
(261, 19, 9, null),
(262, 19, 10, null),
(263, 19, 11, null),
(264, 19, 12, null),
(265, 19, 13, null),
(266, 19, 14, null),
(267, 20, 1, null),
(268, 20, 2, null),
(269, 20, 3, null),
(270, 20, 4, null),
(271, 20, 5, null),
(272, 20, 6, null),
(273, 20, 7, null),
(274, 20, 8, null),
(275, 20, 9, null),
(276, 20, 10, null),
(277, 20, 11, null),
(278, 20, 12, null),
(279, 20, 13, null),
(280, 20, 14, null),

#paciente 3

(281, 21, 1, 1), 
(282, 21, 2, 2),
(283, 21, 3, 2),
(284, 21, 4, 2),
(285, 21, 5, 3),
(286, 21, 6, 2),
(287, 21, 7, 2),
(288, 21, 8, 2),
(289, 21, 9, 2),
(290, 21, 10, 2),
(291, 21, 11, 3),
(292, 21, 12, 2),
(293, 21, 13, 2),
(294, 21, 14, 1),
(295, 22, 1, 3),
(296, 22, 2, 2),
(297, 22, 3, 3),
(298, 22, 4, 2),
(299, 22, 5, 3),
(300, 22, 6, 2),
(301, 22, 7, 1),
(302, 22, 8, 1),
(303, 22, 9, 1),
(304, 22, 10, 1),
(305, 22, 11, 3),
(306, 22, 12, 2),
(307, 22, 13, 2),
(308, 22, 14, 4),
(309, 23, 1, 3),
(310, 23, 2, 2),
(311, 23, 3, 3),
(312, 23, 4, 2),
(313, 23, 5, 1),
(314, 23, 6, 2),
(315, 23, 7, 2),
(316, 23, 8, 2),
(317, 23, 9, 2),
(318, 23, 10, 2),
(319, 23, 11, 2),
(320, 23, 12, 2),
(321, 23, 13, 2),
(322, 23, 14, 4),
(323, 24, 1, 2),
(324, 24, 2, 2),
(325, 24, 3, 1),
(326, 24, 4, 2),
(327, 24, 5, 1),
(328, 24, 6, 2),
(329, 24, 7, 2),
(330, 24, 8, 2),
(331, 24, 9, 2),
(332, 24, 10, 2),
(333, 24, 11, 3),
(334, 24, 12, 2),
(335, 24, 13, 2),
(336, 24, 14, 4),
(337, 25, 1, 1),
(338, 25, 2, 2),
(339, 25, 3, 3),
(340, 25, 4, 2),
(341, 25, 5, 3),
(342, 25, 6, 2),
(343, 25, 7, 2),
(344, 25, 8, 2),
(345, 25, 9, 2),
(346, 25, 10, 2),
(347, 25, 11, 2),
(348, 25, 12, 1),
(349, 25, 13, 2),
(350, 25, 14, 1),
(351, 26, 1, null),
(352, 26, 2, null),
(353, 26, 3, null),
(354, 26, 4, null),
(355, 26, 5, null),
(356, 26, 6, null),
(357, 26, 7, null),
(358, 26, 8, null),
(359, 26, 9, null),
(360, 26, 10, null),
(361, 26, 11, null),
(362, 26, 12, null),
(363, 26, 13, null),
(364, 26, 14, null),
(365, 27, 1, null),
(366, 27, 2, null),
(367, 27, 3, null),
(368, 27, 4, null),
(369, 27, 5, null),
(370, 27, 6, null),
(371, 27, 7, null),
(372, 27, 8, null),
(373, 27, 9, null),
(374, 27, 10, null),
(375, 27, 11, null),
(376, 27, 12, null),
(377, 27, 13, null),
(378, 27, 14, null),
(379, 28, 1, null),
(380, 28, 2, null),
(381, 28, 3, null),
(382, 28, 4, null),
(383, 28, 5, null),
(384, 28, 6, null),
(385, 28, 7, null),
(386, 28, 8, null),
(387, 28, 9, null),
(388, 28, 10, null),
(389, 28, 11, null),
(390, 28, 12, null),
(391, 28, 13, null),
(392, 28, 14, null),
(393, 29, 1, null),
(394, 29, 2, null),
(395, 29, 3, null),
(396, 29, 4, null),
(397, 29, 5, null),
(398, 29, 6, null),
(399, 29, 7, null),
(400, 29, 8, null),
(401, 29, 9, null),
(402, 29, 10, null),
(403, 29, 11, null),
(404, 29, 12, null),
(405, 29, 13, null),
(406, 29, 14, null),
(407, 30, 1, null),
(408, 30, 2, null),
(409, 30, 3, null),
(410, 30, 4, null),
(411, 30, 5, null),
(412, 30, 6, null),
(413, 30, 7, null),
(414, 30, 8, null),
(415, 30, 9, null),
(416, 30, 10, null),
(417, 30, 11, null),
(418, 30, 12, null),
(419, 30, 13, null),
(420, 30, 14, null),

#paciente 4

(421, 31, 1, 2), 
(422, 31, 2, 1),
(423, 31, 3, 4),
(424, 31, 4, 2),
(425, 31, 5, 1),
(426, 31, 6, 3),
(427, 31, 7, 2),
(428, 31, 8, 1),
(429, 31, 9, 2),
(430, 31, 10, 3),
(431, 31, 11, 3),
(432, 31, 12, 1),
(433, 31, 13, 2),
(434, 31, 14, 4),
(435, 32, 1, 3),
(436, 32, 2, 2),
(437, 32, 3, 3),
(438, 32, 4, 2),
(439, 32, 5, 3),
(440, 32, 6, 1),
(441, 32, 7, 2),
(442, 32, 8, 1),
(443, 32, 9, 2),
(444, 32, 10, 4),
(445, 32, 11, 3),
(446, 32, 12, 2),
(447, 32, 13, 2),
(448, 32, 14, 1),
(449, 33, 1, 3),
(450, 33, 2, 2),
(451, 33, 3, 3),
(452, 33, 4, 2),
(453, 33, 5, 3),
(454, 33, 6, 2),
(455, 33, 7, 2),
(456, 33, 8, 2),
(457, 33, 9, 2),
(458, 33, 10, 2),
(459, 33, 11, 2),
(460, 33, 12, 2),
(461, 33, 13, 2),
(462, 33, 14, 2),
(463, 34, 1, 4),
(464, 34, 2, 1),
(465, 34, 3, 1),
(466, 34, 4, 2),
(467, 34, 5, 1),
(468, 34, 6, 2),
(469, 34, 7, 2),
(470, 34, 8, 2),
(471, 34, 9, 2),
(472, 34, 10, 2),
(473, 34, 11, 1),
(474, 34, 12, 2),
(475, 34, 13, 2),
(476, 34, 14, 4),
(477, 35, 1, 1),
(478, 35, 2, 2),
(479, 35, 3, 3),
(480, 35, 4, 2),
(481, 35, 5, 3),
(482, 35, 6, 2),
(483, 35, 7, 2),
(484, 35, 8, 2),
(485, 35, 9, 2),
(486, 35, 10, 2),
(487, 35, 11, 2),
(488, 35, 12, 2),
(489, 35, 13, 4),
(490, 35, 14, 2),
(491, 36, 1, null),
(492, 36, 2, null),
(493, 36, 3, null),
(494, 36, 4, null),
(495, 36, 5, null),
(496, 36, 6, null),
(497, 36, 7, null),
(498, 36, 8, null),
(499, 36, 9, null),
(500, 36, 10, null),
(501, 36, 11, null),
(502, 36, 12, null),
(503, 36, 13, null),
(504, 36, 14, null),
(505, 37, 1, null),
(506, 37, 2, null),
(507, 37, 3, null),
(508, 37, 4, null),
(509, 37, 5, null),
(510, 37, 6, null),
(511, 37, 7, null),
(512, 37, 8, null),
(513, 37, 9, null),
(514, 37, 10, null),
(515, 37, 11, null),
(516, 37, 12, null),
(517, 37, 13, null),
(518, 37, 14, null),
(519, 38, 1, null),
(520, 38, 2, null),
(521, 38, 3, null),
(522, 38, 4, null),
(523, 38, 5, null),
(524, 38, 6, null),
(525, 38, 7, null),
(526, 38, 8, null),
(527, 38, 9, null),
(528, 38, 10, null),
(529, 38, 11, null),
(530, 38, 12, null),
(531, 38, 13, null),
(532, 38, 14, null),
(533, 39, 1, null),
(534, 39, 2, null),
(535, 39, 3, null),
(536, 39, 4, null),
(537, 39, 5, null),
(538, 39, 6, null),
(539, 39, 7, null),
(540, 39, 8, null),
(541, 39, 9, null),
(542, 39, 10, null),
(543, 39, 11, null),
(544, 39, 12, null),
(545, 39, 13, null),
(546, 39, 14, null),
(547, 40, 1, null),
(548, 40, 2, null),
(549, 40, 3, null),
(550, 40, 4, null),
(551, 40, 5, null),
(552, 40, 6, null),
(553, 40, 7, null),
(554, 40, 8, null),
(555, 40, 9, null),
(556, 40, 10, null),
(557, 40, 11, null),
(558, 40, 12, null),
(559, 40, 13, null),
(560, 40, 14, null),

#paciente 5

(561, 41, 1, 1), 
(562, 41, 2, 1),
(563, 41, 3, 1),
(564, 41, 4, 2),
(565, 41, 5, 1),
(566, 41, 6, 1),
(567, 41, 7, 2),
(568, 41, 8, 1),
(569, 41, 9, 1),
(570, 41, 10, 1),
(571, 41, 11, 3),
(572, 41, 12, 1),
(573, 41, 13, 2),
(574, 41, 14, 1),
(575, 42, 1, 3),
(576, 42, 2, 2),
(577, 42, 3, 3),
(578, 42, 4, 1),
(579, 42, 5, 3),
(580, 42, 6, 1),
(581, 42, 7, 2),
(582, 42, 8, 1),
(583, 42, 9, 2),
(584, 42, 10, 1),
(585, 42, 11, 3),
(586, 42, 12, 2),
(587, 42, 13, 2),
(588, 42, 14, 1),
(589, 43, 1, 3),
(590, 43, 2, 2),
(591, 43, 3, 3),
(592, 43, 4, 1),
(593, 43, 5, 3),
(594, 43, 6, 1),
(595, 43, 7, 2),
(596, 43, 8, 1),
(597, 43, 9, 1),
(598, 43, 10, 2),
(599, 43, 11, 1),
(600, 43, 12, 2),
(601, 43, 13, 2),
(602, 43, 14, 1),
(603, 44, 1, 1),
(604, 44, 2, 1),
(605, 44, 3, 1),
(606, 44, 4, 2),
(607, 44, 5, 1),
(608, 44, 6, 2),
(609, 44, 7, 1),
(610, 44, 8, 2),
(611, 44, 9, 2),
(612, 44, 10, 2),
(613, 44, 11, 1),
(614, 44, 12, 2),
(615, 44, 13, 2),
(616, 44, 14, 1),
(617, 45, 1, 1),
(618, 45, 2, 2),
(619, 45, 3, 3),
(620, 45, 4, 2),
(621, 45, 5, 1),
(622, 45, 6, 2),
(623, 45, 7, 2),
(624, 45, 8, 2),
(625, 45, 9, 2),
(626, 45, 10, 2),
(627, 45, 11, 2),
(628, 45, 12, 2),
(629, 45, 13, 1),
(630, 45, 14, 2),
(631, 46, 1, null),
(632, 46, 2, null),
(633, 46, 3, null),
(634, 46, 4, null),
(635, 46, 5, null),
(636, 46, 6, null),
(637, 46, 7, null),
(638, 46, 8, null),
(639, 46, 9, null),
(640, 46, 10, null),
(641, 46, 11, null),
(642, 46, 12, null),
(643, 46, 13, null),
(644, 46, 14, null),
(645, 47, 1, null),
(646, 47, 2, null),
(647, 47, 3, null),
(648, 47, 4, null),
(649, 47, 5, null),
(650, 47, 6, null),
(651, 47, 7, null),
(652, 47, 8, null),
(653, 47, 9, null),
(654, 47, 10, null),
(655, 47, 11, null),
(656, 47, 12, null),
(657, 47, 13, null),
(658, 47, 14, null),
(659, 48, 1, null),
(660, 48, 2, null),
(661, 48, 3, null),
(662, 48, 4, null),
(663, 48, 5, null),
(664, 48, 6, null),
(665, 48, 7, null),
(666, 48, 8, null),
(667, 48, 9, null),
(668, 48, 10, null),
(669, 48, 11, null),
(670, 48, 12, null),
(671, 48, 13, null),
(672, 48, 14, null),
(673, 49, 1, null),
(674, 49, 2, null),
(675, 49, 3, null),
(676, 49, 4, null),
(677, 49, 5, null),
(678, 49, 6, null),
(679, 49, 7, null),
(680, 49, 8, null),
(681, 49, 9, null),
(682, 49, 10, null),
(683, 49, 11, null),
(684, 49, 12, null),
(685, 49, 13, null),
(686, 49, 14, null),
(687, 50, 1, null),
(688, 50, 2, null),
(689, 50, 3, null),
(690, 50, 4, null),
(691, 50, 5, null),
(692, 50, 6, null),
(693, 50, 7, null),
(694, 50, 8, null),
(695, 50, 9, null),
(696, 50, 10, null),
(697, 50, 11, null),
(698, 50, 12, null),
(699, 50, 13, null),
(700, 50, 14, null);



INSERT INTO paciente(id_paciente, nombre, apellido, direccion,telefono, ciudad, estadoCivil, religion, ocupacion, fecha_de_nacimiento)
VALUES(1, 'Pedro', 'Perez', 'Camino al Alamo 207', '8110678922', 'Monterrey','Soltero','Catolico','Estudiante', '1997-06-11'), 
(2, 'Pancho', 'Gutiérrez','Cempoala 380', '8109231655','Monterrey','Soltero','Ateo','Estudiante', '1997-05-14'),
(3, 'Jose', 'Juárez', 'Manzanos 51','5555839200','Monterrey','Casado','Catolico','Empleado','1990-02-20'),
(4, 'Ricardo', 'Ramírez', 'Filosofos 40', '8122775511','Monterrey','Soltero','Ateo','Estudiante','1995-05-25'),
(5, 'Valeria','Vignau','Vasconcelos 109','8712453320','Torreon','Soltero', 'Judio','Empleado','1993-03-12');

INSERT INTO receta_medica(id_receta_medica)
VALUES (1),#paciente1
(2),
(3),
(4),
(5),
#paciente 2
(6),
(7),
(8),
(9),
(10),
#paciente 3
(11),
(12),
(13),
(14),
(15),
#paciente 4
(16),
(17),
(18),
(19),
(20),
#paciente 5
(21),
(22),
(23),
(24),
(25);

INSERT INTO consulta(id_consulta, id_doctor, id_instancia_prueba, id_paciente, fecha, hora, nota_clinica, motivo, estatura, peso, id_receta_medica)
VALUES (1, 1, 1, 1, '2018-01-01', '5:00 pm', 'nota clinica',  'Me he sentido triste últimamente', 1.67, 65, 1), #paciente 1
(2,1,2,1,'2018-01-02','5:00 pm', 'nota clinica', 'Me he sentido triste últimamente', 1.67, 65, null),
(3,1,3,1,'2018-01-03','5:00 pm', 'nota clinica', 'Me he sentido triste últimamente', 1.67, 65, 2),
(4,1,4,1,'2018-01-04','5:00 pm', 'nota clinica', 'Me he sentido triste últimamente', 1.67, 65, null),
(5,1,5,1,'2018-01-05','5:00 pm', 'nota clinica', 'Me he sentido triste últimamente', 1.67, 65, 3),
(6,1,6,1,'2018-01-06','5:00 pm', 'nota clinica', 'Me he sentido triste últimamente', 1.67, 65, null),
(7,1,7,1,'2018-01-07','5:00 pm', 'nota clinica', 'Me he sentido triste últimamente', 1.67, 65, 4),
(8,1,8,1,'2018-01-08','5:00 pm', 'nota clinica', 'Me he sentido triste últimamente', 1.67, 65, null),
(9,1,9,1,'2018-01-09','5:00 pm', 'nota clinica', 'Me he sentido triste últimamente', 1.67, 65, 5),
(10,1,10,1,'2018-01-10','5:00 pm', 'nota clinica', 'Me he sentido triste últimamente', 1.67, 65, null),
#paciente2
(11, 1, 11, 2, '2018-02-01', '6:00 pm', 'nota clinica',  'Cada vez que salgo de mi casa me pongo muy nervioso', 1.70, 75, 6),
(12, 1, 12, 2, '2018-02-02', '6:00 pm', 'nota clinica',  'Cada vez que salgo de mi casa me pongo muy nervioso', 1.70, 75, null),
(13, 1, 13, 2, '2018-02-03', '6:00 pm', 'nota clinica',  'Cada vez que salgo de mi casa me pongo muy nervioso', 1.70, 75, 7),
(14, 1, 14, 2, '2018-02-04', '6:00 pm', 'nota clinica',  'Cada vez que salgo de mi casa me pongo muy nervioso', 1.70, 75, null),
(15, 1, 15, 2, '2018-02-05', '6:00 pm', 'nota clinica',  'Cada vez que salgo de mi casa me pongo muy nervioso', 1.70, 75, 8),
(16, 1, 16, 2, '2018-02-06', '6:00 pm', 'nota clinica',  'Cada vez que salgo de mi casa me pongo muy nervioso', 1.70, 75, null),
(17, 1, 17, 2, '2018-02-07', '6:00 pm', 'nota clinica',  'Cada vez que salgo de mi casa me pongo muy nervioso', 1.70, 75, 9),
(18, 1, 18, 2, '2018-02-08', '6:00 pm', 'nota clinica',  'Cada vez que salgo de mi casa me pongo muy nervioso', 1.70, 75, null),
(19, 1, 19, 2, '2018-02-09', '6:00 pm', 'nota clinica',  'Cada vez que salgo de mi casa me pongo muy nervioso', 1.70, 75, 10),
(20, 1, 20, 2, '2018-02-10', '6:00 pm', 'nota clinica',  'Cada vez que salgo de mi casa me pongo muy nervioso', 1.70, 75, null),
#paciente3
(21, 1, 21, 3, '2018-03-01', '7:00 pm', 'nota clinica',  'No tolero hablar en público', 1.75, 70, 11),
(22, 1, 22, 3, '2018-03-02', '7:00 pm', 'nota clinica',  'No tolero hablar en público', 1.75, 70, null),
(23, 1, 23, 3, '2018-03-03', '7:00 pm', 'nota clinica',  'No tolero hablar en público', 1.75, 70, 12),
(24, 1, 24, 3, '2018-03-04', '7:00 pm', 'nota clinica',  'No tolero hablar en público', 1.75, 70, null),
(25, 1, 25, 3, '2018-03-05', '7:00 pm', 'nota clinica',  'No tolero hablar en público', 1.75, 70, 13),
(26, 1, 26, 3, '2018-03-06', '7:00 pm', 'nota clinica',  'No tolero hablar en público', 1.75, 70, null),
(27, 1, 27, 3, '2018-03-07', '7:00 pm', 'nota clinica',  'No tolero hablar en público', 1.75, 70, 14),
(28, 1, 28, 3, '2018-03-08', '7:00 pm', 'nota clinica',  'No tolero hablar en público', 1.75, 70, null),
(29, 1, 29, 3, '2018-03-09', '7:00 pm', 'nota clinica',  'No tolero hablar en público', 1.75, 70, 15),
(30, 1, 30, 3, '2018-03-10', '7:00 pm', 'nota clinica',  'No tolero hablar en público', 1.75, 70, null),
#paciente 4
(31, 1, 31, 4, '2018-04-01', '8:00 pm', 'nota clinica',  'Me siento insuficiente', 1.60, 40, 16),
(32, 1, 32, 4, '2018-04-02', '8:00 pm', 'nota clinica',  'Me siento insuficiente', 1.60, 40, null),
(33, 1, 33, 4, '2018-04-03', '8:00 pm', 'nota clinica',  'Me siento insuficiente', 1.60, 40, 17),
(34, 1, 34, 4, '2018-04-04', '8:00 pm', 'nota clinica',  'Me siento insuficiente', 1.60, 40, null),
(35, 1, 35, 4, '2018-04-05', '8:00 pm', 'nota clinica',  'Me siento insuficiente', 1.60, 40, 18),
(36, 1, 36, 4, '2018-04-06', '8:00 pm', 'nota clinica',  'Me siento insuficiente', 1.60, 40, null),
(37, 1, 37, 4, '2018-04-07', '8:00 pm', 'nota clinica',  'Me siento insuficiente', 1.60, 40, 19),
(38, 1, 38, 4, '2018-04-08', '8:00 pm', 'nota clinica',  'Me siento insuficiente', 1.60, 40, null),
(39, 1, 39, 4, '2018-04-09', '8:00 pm', 'nota clinica',  'Me siento insuficiente', 1.60, 40, 20),
(40, 1, 40, 4, '2018-04-10', '8:00 pm', 'nota clinica',  'Me siento insuficiente', 1.60, 40, null),
#paciente 5
(41, 1, 41, 5, '2018-05-01', '9:00 pm', 'nota clinica',  'Cuando se me acerca un hombre me pongo muy nerviosa', 1.80, 80, 21),
(42, 1, 42, 5, '2018-05-02', '9:00 pm', 'nota clinica',  'Cuando se me acerca un hombre me pongo muy nerviosa', 1.80, 80, null),
(43, 1, 43, 5, '2018-05-03', '9:00 pm', 'nota clinica',  'Cuando se me acerca un hombre me pongo muy nerviosa', 1.80, 80, 22),
(44, 1, 44, 5, '2018-05-04', '9:00 pm', 'nota clinica',  'Cuando se me acerca un hombre me pongo muy nerviosa', 1.80, 80, null),
(45, 1, 45, 5, '2018-05-05', '9:00 pm', 'nota clinica',  'Cuando se me acerca un hombre me pongo muy nerviosa', 1.80, 80, 23),
(46, 1, 46, 5, '2018-05-06', '9:00 pm', 'nota clinica',  'Cuando se me acerca un hombre me pongo muy nerviosa', 1.80, 80, null),
(47, 1, 47, 5, '2018-05-07', '9:00 pm', 'nota clinica',  'Cuando se me acerca un hombre me pongo muy nerviosa', 1.80, 80, 24),
(48, 1, 48, 5, '2018-05-08', '9:00 pm', 'nota clinica',  'Cuando se me acerca un hombre me pongo muy nerviosa', 1.80, 80, null),
(49, 1, 49, 5, '2018-05-09', '9:00 pm', 'nota clinica',  'Cuando se me acerca un hombre me pongo muy nerviosa', 1.80, 80, 25),
(50, 1, 50, 5, '2018-05-10', '9:00 pm', 'nota clinica',  'Cuando se me acerca un hombre me pongo muy nerviosa', 1.80, 80, null);

INSERT INTO dsm5(id_dsm5, icd9, icd10, dsm5_descripcion)
VALUES (1, '290', 'F03', 'El paciente presenta demencia.'),
(2,'300','F05','El paciente tiene episodios de deliración.'),
(3, '300', 'F05', 'El paciente tiene episodios de deliración.'),
(4, '300.4', 'F33', 'El paciente tiene depresión recurrente.'),
(5,'302.2','F40','El paciente tiene trastornos de ansiedad fóbica.');

INSERT INTO medicamento(id_medicamento, nombre, ingrediente_activo, laboratorio, presentacion)
VALUES (1, 'Tressvin', 'Sertralina', 'ifa Celtics', 'Tabletas'), #50mg
(2,'Farmaxetina','Fluoxetina','ifa Celtics','Tabletas'), #20mg
(3, 'TIM ASF','Quetiapina', 'Asofarma', 'Tabletas'), #10mg
(4, 'Ativan', 'Lorazepam', 'Pfizer', 'Tabletas'), #1mg
(5, 'Valium', 'Diazepam', 'Roche', 'Comprimidos'), #10mg
(6, 'Prozac', 'Fluoxetina','Dista','Comprimidos'); #20mg

INSERT INTO detalle_receta(id_receta_medica,id_medicamento, instrucciones, dias, frecuencia, dosis)
VALUES (1, 1, 'tomar cada 8 horas', 3, 3, '50mg'),#paciente 1
(1,2,'tomar cada 6 horas',3,3,'20mg'),
(1,3,'tomar cada 8 horas',3,3,'10mg'),
(2,4,'tomar cada 12 horas',3,3,'1mg'),
(2,2,'tomar cada 6 horas',3,3,'20mg'),
(2,5,'tomar cada 8 horas',3,3,'10mg'),
(3,6,'tomar cada 8 horas',3,3,'20mg'),
(3,3,'tomar cada 8 horas',3,3,'100mg'),
(3,1,'tomar cada 8 horas',3,3,'50mg'),
(4,2,'tomar cada 6 horas',3,3,'20mg'),
(4,3,'tomar cada 8 horas',3,3,'10mg'),
(4,6,'tomar cada 8 horas',3,3,'20mg'),
(5,4,'tomar cada 12 horas',3,3,'1mg'),
(5,2,'tomar cada 6 horas',3,3,'20mg'),
(5,6,'tomar cada 8 horas',3,3,'20mg'),
#paciente 2
(6, 1, 'tomar cada 8 horas', 3, 3, '50mg'),
(6, 3, 'tomar cada 8 horas',3,3,'10mg'),
(6,5,'tomar cada 8 horas',3,3,'10mg'),
(7,2,'tomar cada 6 horas',3,3,'20mg'),
(7,1, 'tomar cada 8 horas', 3, 3, '50mg'),
(7,4,'tomar cada 12 horas',3,3,'1mg'),
(8,1,'tomar cada 8 horas', 3, 3, '50mg'),
(8,2,'tomar cada 6 horas',3,3,'20mg'),
(8,6,'tomar cada 8 horas',3,3,'20mg'),
(9,6,'tomar cada 8 horas',3,3,'20mg'),
(9,4,'tomar cada 12 horas',3,3,'1mg'),
(9,3,'tomar cada 8 horas',3,3,'10mg'),
(10,1,'tomar cada 8 horas',3,3,'50mg'),
(10,2,'tomar cada 6 horas',3,3,'20mg'),
(10,5,'tomar cada 8 horas',3,3,'10mg'),
#paciente 3
(11, 1, 'tomar cada 8 horas', 3, 3, '50mg'),
(11, 4,'tomar cada 12 horas',3,3,'1mg'),
(11, 3,'tomar cada 8 horas',3,3,'10mg'),
(12, 2,'tomar cada 6 horas',3,3,'20mg'),
(12, 6,'tomar cada 8 horas',3,3,'20mg'),
(12, 5,'tomar cada 8 horas',3,3,'10mg'),
(13, 5,'tomar cada 8 horas',3,3,'10mg'),
(13, 1, 'tomar cada 8 horas', 3, 3, '50mg'),
(13, 3,'tomar cada 8 horas',3,3,'10mg'),
(14, 1, 'tomar cada 8 horas', 3, 3, '50mg'),
(14, 2,'tomar cada 6 horas',3,3,'20mg'),
(14, 4,'tomar cada 12 horas',3,3,'1mg'),
(15, 6,'tomar cada 8 horas',3,3,'20mg'),
(15, 1,'tomar cada 8 horas',3,3,'50mg'),
(15, 3,'tomar cada 8 horas',3,3,'10mg'),
#paciente 4
(16, 5,'tomar cada 8 horas',3,3,'10mg'),
(16, 1,'tomar cada 8 horas',3,3,'50mg'),
(16, 2,'tomar cada 6 horas',3,3,'20mg'),
(17, 3,'tomar cada 8 horas',3,3,'10mg'),
(17, 6,'tomar cada 8 horas',3,3,'20mg'),
(17, 1, 'tomar cada 8 horas', 3, 3, '50mg'),
(18, 4,'tomar cada 12 horas',3,3,'1mg'),
(18, 5,'tomar cada 8 horas',3,3,'10mg'),
(18, 6,'tomar cada 8 horas',3,3,'20mg'),
(19, 2,'tomar cada 6 horas',3,3,'20mg'),
(19, 1, 'tomar cada 8 horas', 3, 3, '50mg'),
(19, 4,'tomar cada 12 horas',3,3,'1mg'),
(20, 5,'tomar cada 8 horas',3,3,'10mg'),
(20, 4,'tomar cada 12 horas',3,3,'1mg'),
(20, 3,'tomar cada 8 horas',3,3,'10mg'),
#paciente 5
(21,3,'tomar cada 8 horas',3,3,'10mg'),
(21,4,'tomar cada 12 horas',3,3,'1mg'),
(21,1,'tomar cada 8 horas',3,3,'50mg'),
(22,6,'tomar cada 8 horas',3,3,'20mg'),
(22,2,'tomar cada 6 horas',3,3,'20mg'),
(22,5,'tomar cada 8 horas',3,3,'10mg'),
(23,1, 'tomar cada 8 horas', 3, 3, '50mg'),
(23,3,'tomar cada 8 horas',3,3,'10mg'),
(23,2,'tomar cada 6 horas',3,3,'20mg'),
(24,5,'tomar cada 8 horas',3,3,'10mg'),
(24,4,'tomar cada 12 horas',3,3,'1mg'),
(24,3,'tomar cada 8 horas',3,3,'10mg'),
(25,2,'tomar cada 6 horas',3,3,'20mg'),
(25,1, 'tomar cada 8 horas', 3, 3, '50mg'),
(25,6,'tomar cada 8 horas',3,3,'20mg');

INSERT INTO diagnostico(id_dsm5, id_consulta)
VALUES (1, 5),
(1, 6),
(2, 10),
(3, 15),
(3, 16),
(3, 17),
(4, 20),
(5, 25),
(2, 28),
(3, 32),
(1, 35),
(5, 39),
(4, 42),
(1, 46),
(5, 48),
(3, 50);

INSERT INTO informacion_medica_paciente(id_informacion_medica_paciente, id_paciente, tipo_de_sangre, fuma, tiene_problema_alcohol)
VALUES (1, 1, 'O', false, false),
(2, 2, 'AB', true, false),
(3, 3, 'A+', false, true),
(4, 4, 'B-', true, true),
(5, 5, 'O+', false, false);

INSERT INTO catalogo_alergias(id_catalogo_alergias, id_paciente, nombre_alergia)
VALUES (1,1,'lácteos'),
(2,2,'polen'),
(3,3,'pasto'),
(4,4,'pescado'),
(5,5,'penicilina');

(select id_instancia_prueba, sum(valor) from respuesta_prueba
group by id_instancia_prueba);

SET SQL_SAFE_UPDATES = 0;

update instancia_prueba ip
inner join (
select id_instancia_prueba, sum(valor) valsum
from respuesta_prueba
group by id_instancia_prueba
) f on ip.id_instancia_prueba = f.id_instancia_prueba
set ip.total = f.valsum;