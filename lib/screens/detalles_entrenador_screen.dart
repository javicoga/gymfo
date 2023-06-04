import 'package:flutter/material.dart';
import 'package:gymfo/screens/form.dart';
import 'package:gymfo/widgets/appbar_widget.dart';
import '../models/models.dart';
import 'package:url_launcher/url_launcher.dart';

class DetallesEntrenadorScreen extends StatefulWidget {
  final Cliente clienteActual;
  final Entrenador entrenador;
  final Color color;
  const DetallesEntrenadorScreen({super.key, required this.entrenador, required this.clienteActual, required this.color});

  @override
  State<DetallesEntrenadorScreen> createState() => _DetallesEntrenadorScreenState();
}

class _DetallesEntrenadorScreenState extends State<DetallesEntrenadorScreen> {
  bool mostrarWidget = false;
  bool mostrarBoton = true;
  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = new ScrollController();
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: appBar(context, widget.clienteActual, widget.color),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(top: BorderSide(
                width: 2,
                color: Colors.black
              )),
              color: widget.color
            ),
            child: Text(
              widget.entrenador.nombre, style: TextStyle(fontSize: 32), textAlign: TextAlign.center,
              ),
            ),
          Container(
            height: 200,
            child: Row(
              children: [
                SizedBox(height: 30,),
                Container(
                  margin: EdgeInsets.only( left: 20, right: 20),
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(
                      image: NetworkImage(widget.entrenador.imagen),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                  Container(
                      width: 150,
                      height: 150,
                      child: Scrollbar(
                        controller: _scrollController,
                        thumbVisibility: true,
                        trackVisibility: true,
                        radius: Radius.circular(50),
                        thickness: 5,
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: Text(
                            widget.entrenador.descripcion,
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ),
              ],
            ),
          ),
          Container(
            color: widget.color,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: filaIconos,
            ),
          ),
          SizedBox(height: 30,),
          Visibility(
            visible: mostrarBoton,
            child: ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(widget.color), padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 50, vertical: 15))),
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContratarForm(entrenador: widget.entrenador, clienteActual: widget.clienteActual, color: widget.color,),
                    ),
                  );
              }, 
            child: Text("Contratar")),
          ),
        ],
      ),
      bottomNavigationBar: Container(
            margin: EdgeInsets.only(top: 100),
            color: widget.color,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(onPressed: () async {
                  Uri url = Uri.parse(widget.entrenador.youtube);
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                     }, 
                icon: Image.asset('icons/youtube.png',)),
                IconButton(onPressed: () async {
                  Uri url = Uri.parse(widget.entrenador.instagram);
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                     }, 
                icon: Image.asset('icons/instagram.png',)),
              ],
            ),
          ),
    );
  }

  List<Widget> get filaIconos {
    return [
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: const Text('Especialidades:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
              ),
              SizedBox(width: 15,),
              if(widget.entrenador.especialidad.contains('femenino'))
              IconButton(
                icon: Image.network('https://res.cloudinary.com/djtofkkp9/image/upload/v1678674750/gugfgeie1ufgjrvt7sct.png'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        icon: Image.network('https://res.cloudinary.com/djtofkkp9/image/upload/v1678674750/gugfgeie1ufgjrvt7sct.png', width: 64, height: 64,),
                        title: Text('Entrenamiento femenino'),
                        content: Text('La especialidad en entrenamiento femenino se refiere a la capacidad para diseñar programas de entrenamiento personalizados que se adapten a las necesidades y objetivos específicos de las mujeres.'),
                        actions: [
                          TextButton(
                            onPressed: (){
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    icon: Image.network('https://res.cloudinary.com/djtofkkp9/image/upload/v1678674750/gugfgeie1ufgjrvt7sct.png', width: 64, height: 64,),
                                    content: SingleChildScrollView(child: Text('Un buen entrenador personal debe comprender las diferencias fisiológicas y psicológicas entre hombres y mujeres, y cómo estas diferencias pueden afectar la forma en que las mujeres responden al entrenamiento y a la nutrición. Por ejemplo, las mujeres suelen tener menos masa muscular y una menor capacidad cardiovascular que los hombres, lo que puede afectar la intensidad y duración del entrenamiento. Además, un entrenador personal especializado en el entrenamiento femenino debe estar familiarizado con las etapas del ciclo menstrual y cómo pueden afectar el rendimiento y la recuperación de las mujeres durante el entrenamiento. También es importante que el entrenador personal tenga en cuenta cualquier lesión o condición médica preexistente que pueda afectar el entrenamiento de las mujeres. El entrenador personal debe ser capaz de motivar y apoyar a sus clientes femeninas, y ayudarlas a establecer metas realistas y alcanzables. También debe ser capaz de adaptar el programa de entrenamiento y nutrición a medida que sus clientes progresan y se acercan a sus objetivos. En resumen, la capacidad de entrenamiento femenino de un entrenador personal implica tener un enfoque personalizado y específico para las necesidades y objetivos de las mujeres que entrenan.')),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Cerrar', style: TextStyle(color: Colors.red),),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }, 
                            child: Text('Más información')),
                            TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cerrar', style: TextStyle(color: Colors.red),),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              if(widget.entrenador.especialidad.contains('femenino'))
              SizedBox(width: 15,),
              if(widget.entrenador.especialidad.contains('bajar peso'))
              IconButton(
                onPressed: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        icon: Image.network('https://res.cloudinary.com/djtofkkp9/image/upload/v1678674812/lxydzsfu7dr9bfg2oakz.png', width: 64, height: 64,),
                        title: Text('Pérdida de peso'),
                        content: Text('La especialidad en pérdida de peso se refiere a la capacidad para diseñar programas de entrenamiento y planes de alimentación personalizados que ayuden a las personas a perder peso de manera efectiva y saludable.'),
                        actions: [
                          TextButton(
                            onPressed: (){
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    icon: Image.network('https://res.cloudinary.com/djtofkkp9/image/upload/v1678674812/lxydzsfu7dr9bfg2oakz.png', width: 64, height: 64,),
                                    content: SingleChildScrollView(child: Text('Un entrenador personal especializado en bajar de peso debe tener conocimientos sólidos en nutrición y fisiología del ejercicio, así como habilidades para motivar a sus clientes y ayudarles a establecer metas realistas y alcanzables. El entrenador personal también debe tener en cuenta las necesidades y limitaciones individuales de sus clientes, tales como la edad, la condición física actual y cualquier lesión o condición médica preexistente, para adaptar el programa de entrenamiento y alimentación de manera adecuada. Además, un buen entrenador personal debe proporcionar apoyo y seguimiento constante a lo largo del proceso de pérdida de peso para asegurar que sus clientes logren sus objetivos de manera saludable y sostenible a largo plazo.')),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Cerrar', style: TextStyle(color: Colors.red),),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }, 
                            child: Text('Más información')),
                            TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cerrar', style: TextStyle(color: Colors.red),),
                          ),
                        ],
                      );
                    },
                  );
                }, 
                icon: Image.network('https://res.cloudinary.com/djtofkkp9/image/upload/v1678674812/lxydzsfu7dr9bfg2oakz.png',width: 32, height: 32,),),
              if(widget.entrenador.especialidad.contains('bajar peso'))
              SizedBox(width: 15,),
              if(widget.entrenador.especialidad.contains('subir peso'))
              IconButton(
                onPressed: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        icon: Image.network('https://res.cloudinary.com/djtofkkp9/image/upload/v1678723036/bb3zrpkr8ckivz8o6yqj.png', width: 64, height: 64,),
                        title: Text('Ganancia de peso'),
                        content: Text('La especialidad en subir de peso de un entrenador personal se refiere a su capacidad para diseñar programas de entrenamiento y nutrición personalizados que ayuden a sus clientes a aumentar su masa muscular y ganar peso de manera saludable.'),
                        actions: [
                          TextButton(
                            onPressed: (){
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    icon: Image.network('https://res.cloudinary.com/djtofkkp9/image/upload/v1678723036/bb3zrpkr8ckivz8o6yqj.png', width: 64, height: 64,),
                                    content: SingleChildScrollView(child: Text('Un entrenador personal especializado en subir de peso debe tener un conocimiento sólido en nutrición deportiva y fisiología del ejercicio. Debe ser capaz de evaluar las necesidades y objetivos individuales de cada cliente, así como su nivel de condición física actual y cualquier limitación física o lesión previa que puedan afectar su entrenamiento. A partir de la evaluación, el entrenador personal debe diseñar un programa de entrenamiento personalizado que incluya ejercicios de fuerza y resistencia, así como planes de nutrición personalizados que aseguren un aumento gradual y saludable de la masa muscular y del peso corporal. El programa debe ser ajustado y supervisado continuamente para asegurarse de que el cliente está progresando de manera segura y efectiva.')),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Cerrar', style: TextStyle(color: Colors.red),),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }, 
                            child: Text('Más información')),
                            TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cerrar', style: TextStyle(color: Colors.red),),
                          ),
                        ],
                      );
                    },
                  );
                }, 
                icon: Image.network('https://res.cloudinary.com/djtofkkp9/image/upload/v1678723036/bb3zrpkr8ckivz8o6yqj.png',width: 32, height: 32,),),
              if(widget.entrenador.especialidad.contains('subir peso'))
              SizedBox(width: 15,),
              if(widget.entrenador.especialidad.contains('lesiones'))
              IconButton(
                onPressed: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        icon: Image.network('https://res.cloudinary.com/djtofkkp9/image/upload/v1678722440/u5iso8a58bxwkpuhovaz.png', width: 64, height: 64,),
                        title: Text('Lesiones'),
                        content: Text('La especialidad en lesiones de un entrenador personal se refiere a su capacidad para diseñar programas de entrenamiento personalizados para personas que han sufrido lesiones o que tienen afecciones médicas que limitan su capacidad para realizar ciertos ejercicios.'),
                        actions: [
                          TextButton(
                            onPressed: (){
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    icon: Image.network('https://res.cloudinary.com/djtofkkp9/image/upload/v1678723418/cjflukp60ecrln64fxxt.png', width: 64, height: 64,),
                                    content: SingleChildScrollView(child: Text('Un entrenador personal especializado en lesiones debe tener conocimientos sólidos en anatomía y fisiología, así como en las diferentes lesiones y condiciones médicas que pueden afectar el entrenamiento y la recuperación de una persona. El entrenador personal también debe tener habilidades para evaluar la gravedad de una lesión y adaptar el programa de entrenamiento en consecuencia. Además, debe ser capaz de trabajar en estrecha colaboración con profesionales de la salud, como fisioterapeutas o médicos, para asegurar que el programa de entrenamiento esté alineado con el plan de tratamiento de la lesión o afección médica. Además, un buen entrenador personal especializado en lesiones debe estar familiarizado con técnicas de rehabilitación y terapia física, y ser capaz de incorporarlas en el programa de entrenamiento de manera efectiva. También debe ser capaz de proporcionar apoyo emocional y motivacional para ayudar a los clientes a superar cualquier miedo o ansiedad relacionados con su lesión o afección médica. En resumen, la especialidad en lesiones de un entrenador personal implica la capacidad de diseñar programas de entrenamiento seguros y efectivos que ayuden a las personas a recuperarse de lesiones y afecciones médicas, y a mejorar su calidad de vida.')),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Cerrar', style: TextStyle(color: Colors.red),),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }, 
                            child: Text('Más información')),
                            TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cerrar', style: TextStyle(color: Colors.red),),
                          ),
                        ],
                      );
                    },
                  );
                }, 
                icon: Image.network('https://res.cloudinary.com/djtofkkp9/image/upload/v1678722440/u5iso8a58bxwkpuhovaz.png',width: 32, height: 32,),),
              
              if(widget.entrenador.especialidad.contains('lesiones'))
              SizedBox(width: 15,),
              if(widget.entrenador.especialidad.contains('cardio'))
              IconButton(
                onPressed: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        icon: Image.network('https://res.cloudinary.com/djtofkkp9/image/upload/v1678723418/cjflukp60ecrln64fxxt.png', width: 64, height: 64,),
                        title: Text('Cardio'),
                        content: Text('La especialidad en cardio de un entrenador personal se refiere a su capacidad para diseñar programas de entrenamiento cardiovascular personalizados que mejoren la resistencia y la salud cardiovascular de sus clientes.'),
                        actions: [
                          TextButton(
                            onPressed: (){
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    icon: Image.network('https://res.cloudinary.com/djtofkkp9/image/upload/v1678723418/cjflukp60ecrln64fxxt.png', width: 64, height: 64,),
                                    content: SingleChildScrollView(child: Text('Un entrenador personal especializado en cardio debe tener conocimientos sólidos en fisiología del ejercicio y en cómo el sistema cardiovascular responde al ejercicio. Debe ser capaz de diseñar programas de entrenamiento que incluyan una combinación adecuada de ejercicios aeróbicos, intervalos de alta intensidad y entrenamiento de resistencia, para mejorar la resistencia cardiovascular, la quema de grasa y la fuerza muscular. El entrenador personal también debe tener en cuenta las necesidades y limitaciones individuales de sus clientes, como la edad, el nivel de condición física actual y cualquier lesión o condición médica preexistente que pueda afectar el entrenamiento. Además, un buen entrenador personal especializado en cardio debe ser capaz de motivar y apoyar a sus clientes, proporcionándoles consejos sobre nutrición y hábitos de vida saludables que mejoren sus resultados. También debe estar al tanto de las últimas tendencias en entrenamiento cardiovascular y ser capaz de incorporarlas en los programas de entrenamiento de sus clientes de manera efectiva. En resumen, la especialidad en cardio de un entrenador personal implica la capacidad de diseñar programas de entrenamiento cardiovascular personalizados que mejoren la salud cardiovascular y la resistencia de sus clientes de manera efectiva y segura.')),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Cerrar', style: TextStyle(color: Colors.red),),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }, 
                            child: Text('Más información')),
                            TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cerrar', style: TextStyle(color: Colors.red),),
                          ),
                        ],
                      );
                    },
                  );
                }, 
                icon: Image.network('https://res.cloudinary.com/djtofkkp9/image/upload/v1678723418/cjflukp60ecrln64fxxt.png',width: 32, height: 32,),),
              if(widget.entrenador.especialidad.contains('cardio'))
              SizedBox(width: 15,),
              if(widget.entrenador.especialidad.contains('fuerza'))
              IconButton(
                onPressed: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        icon: Image.network('https://res.cloudinary.com/djtofkkp9/image/upload/v1678723030/urjflulypesmwa1desl7.png', width: 64, height: 64,),
                        title: Text('Fuerza'),
                        content: Text('La especialidad en fuerza de un entrenador personal se refiere a su capacidad para diseñar programas de entrenamiento de fuerza personalizados que ayuden a sus clientes a aumentar la masa muscular y mejorar la fuerza'),
                        actions: [
                          TextButton(
                            onPressed: (){
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    icon: Image.network('https://res.cloudinary.com/djtofkkp9/image/upload/v1678723030/urjflulypesmwa1desl7.png', width: 64, height: 64,),
                                    content: SingleChildScrollView(child: Text('Un entrenador personal especializado en fuerza debe tener conocimientos sólidos en anatomía y fisiología, así como en los principios del entrenamiento de fuerza, como la periodización y la progresión de cargas. Debe ser capaz de diseñar programas de entrenamiento que incluyan una combinación adecuada de ejercicios de fuerza, resistencia y acondicionamiento, para mejorar la fuerza muscular, la resistencia y la capacidad para realizar actividades diarias. El entrenador personal también debe tener en cuenta las necesidades y limitaciones individuales de sus clientes, tales como la edad, la condición física actual y cualquier lesión o condición médica preexistente, para adaptar el programa de entrenamiento en consecuencia. Además, un buen entrenador personal especializado en fuerza debe ser capaz de proporcionar a sus clientes la técnica adecuada de levantamiento de pesas y supervisión durante el entrenamiento, para evitar lesiones. También debe ser capaz de motivar y apoyar a sus clientes a lo largo del proceso de entrenamiento de fuerza, proporcionándoles consejos sobre nutrición y hábitos de vida saludables que mejoren sus resultados. En resumen, la especialidad en fuerza de un entrenador personal implica la capacidad de diseñar programas de entrenamiento de fuerza personalizados que mejoren la masa muscular, la fuerza, la resistencia y la salud de los clientes, al mismo tiempo que se minimizan los riesgos de lesiones.')),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Cerrar', style: TextStyle(color: Colors.red),),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }, 
                            child: Text('Más información')),
                            TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cerrar', style: TextStyle(color: Colors.red),),
                          ),
                        ],
                      );
                    },
                  );
                }, 
                icon: Image.network('https://res.cloudinary.com/djtofkkp9/image/upload/v1678723030/urjflulypesmwa1desl7.png',width: 32, height: 32,),),
              if(widget.entrenador.especialidad.contains('fuerza'))
              SizedBox(width: 15,),
              if(widget.entrenador.especialidad.contains('nutricion'))
              IconButton(
                onPressed: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        icon: Image.network('https://res.cloudinary.com/djtofkkp9/image/upload/v1678723200/fkkgt5dag1unbndcfs7e.png', width: 64, height: 64,),
                        title: Text('Nutrición'),
                        content: Text('La especialidad en nutrición de un entrenador personal se refiere a su capacidad para proporcionar asesoramiento en nutrición y diseñar planes de alimentación personalizados para sus clientes.'),
                        actions: [
                          TextButton(
                            onPressed: (){
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    icon: Image.network('https://res.cloudinary.com/djtofkkp9/image/upload/v1678723200/fkkgt5dag1unbndcfs7e.png', width: 64, height: 64,),
                                    content: SingleChildScrollView(child: Text('Un entrenador personal especializado en nutrición debe tener conocimientos sólidos en nutrición y bioquímica, así como en los requisitos nutricionales individuales, para diseñar planes de alimentación que satisfagan las necesidades nutricionales de sus clientes y se ajusten a sus objetivos de salud y acondicionamiento físico. El entrenador personal también debe tener en cuenta las necesidades y preferencias alimentarias individuales de sus clientes, así como cualquier afección médica preexistente que pueda afectar sus necesidades nutricionales. Además, un buen entrenador personal especializado en nutrición debe estar al tanto de las últimas tendencias y descubrimientos en nutrición y ser capaz de proporcionar consejos nutricionales actualizados y efectivos para sus clientes. También debe ser capaz de motivar y apoyar a sus clientes, para que puedan mantener una dieta saludable y sostenible a largo plazo. En resumen, la especialidad en nutrición de un entrenador personal implica la capacidad de proporcionar asesoramiento nutricional y diseñar planes de alimentación personalizados que satisfagan las necesidades individuales de sus clientes y ayuden a alcanzar sus objetivos de salud y acondicionamiento físico.')),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Cerrar', style: TextStyle(color: Colors.red),),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }, 
                            child: Text('Más información')),
                            TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cerrar', style: TextStyle(color: Colors.red),),
                          ),
                        ],
                      );
                    },
                  );
                }, 
                icon: Image.network('https://res.cloudinary.com/djtofkkp9/image/upload/v1678723200/fkkgt5dag1unbndcfs7e.png',width: 32, height: 32,),),
              if(widget.entrenador.especialidad.contains('nutricion'))
              SizedBox(width: 15,),
              if(widget.entrenador.especialidad.contains('resistencia'))
              IconButton(
                onPressed: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        icon: Image.network('https://res.cloudinary.com/djtofkkp9/image/upload/v1678723025/dovehfzwe3q4mtrs0bxg.png', width: 64, height: 64,),
                        title: Text('Resistencia'),
                        content: Text('La especialidad en resistencia de un entrenador personal se refiere a su capacidad para diseñar programas de entrenamiento personalizados que mejoren la resistencia cardiovascular y muscular de sus clientes.'),
                        actions: [
                          TextButton(
                            onPressed: (){
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    icon: Image.network('https://res.cloudinary.com/djtofkkp9/image/upload/v1678723025/dovehfzwe3q4mtrs0bxg.png', width: 64, height: 64,),
                                    content: SingleChildScrollView(child: Text('Un entrenador personal especializado en resistencia debe tener conocimientos sólidos en fisiología del ejercicio y en cómo el cuerpo responde al entrenamiento de resistencia. Debe ser capaz de diseñar programas de entrenamiento que incluyan una combinación adecuada de ejercicios de resistencia, entrenamiento cardiovascular y acondicionamiento, para mejorar la resistencia muscular y cardiovascular de sus clientes. El entrenador personal también debe tener en cuenta las necesidades y limitaciones individuales de sus clientes, como la edad, el nivel de condición física actual y cualquier lesión o condición médica preexistente que pueda afectar el entrenamiento. Además, un buen entrenador personal especializado en resistencia debe ser capaz de motivar y apoyar a sus clientes, proporcionándoles consejos sobre nutrición y hábitos de vida saludables que mejoren sus resultados. También debe estar al tanto de las últimas tendencias en entrenamiento de resistencia y ser capaz de incorporarlas en los programas de entrenamiento de sus clientes de manera efectiva. En resumen, la especialidad en resistencia de un entrenador personal implica la capacidad de diseñar programas de entrenamiento personalizados que mejoren la resistencia cardiovascular y muscular de sus clientes de manera efectiva y segura.')),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Cerrar', style: TextStyle(color: Colors.red),),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }, 
                            child: Text('Más información')),
                            TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cerrar', style: TextStyle(color: Colors.red),),
                          ),
                        ],
                      );
                    },
                  );
                }, 
                icon: Image.network('https://res.cloudinary.com/djtofkkp9/image/upload/v1678723025/dovehfzwe3q4mtrs0bxg.png',width: 32, height: 32,),),
              if(widget.entrenador.especialidad.contains('resistencia'))
              SizedBox(width: 15,),
              if(widget.entrenador.especialidad.contains('competicion'))
              IconButton(
                onPressed: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        icon: Image.network('https://res.cloudinary.com/djtofkkp9/image/upload/v1678725264/gipzep9tbusuuwixusty.png', width: 64, height: 64,),
                        title: Text('Competición'),
                        content: Text('La especialidad en competición de un entrenador personal se refiere a su capacidad para diseñar programas de entrenamiento personalizados que preparen a sus clientes para competir en eventos deportivos y lograr sus objetivos competitivos.'),
                        actions: [
                          TextButton(
                            onPressed: (){
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    icon: Image.network('https://res.cloudinary.com/djtofkkp9/image/upload/v1678725264/gipzep9tbusuuwixusty.png', width: 64, height: 64,),
                                    content: SingleChildScrollView(child: Text('Un entrenador personal especializado en competición debe tener conocimientos sólidos en fisiología del ejercicio, periodización del entrenamiento y estrategias de entrenamiento específicas para cada deporte. Debe ser capaz de diseñar programas de entrenamiento que incluyan una combinación adecuada de ejercicios de resistencia, entrenamiento cardiovascular y acondicionamiento, para mejorar la fuerza, la velocidad, la agilidad y la técnica deportiva de sus clientes. El entrenador personal también debe tener en cuenta las necesidades y limitaciones individuales de sus clientes, como el nivel de experiencia, la edad, la posición deportiva y cualquier lesión o condición médica preexistente que pueda afectar el entrenamiento. Además, un buen entrenador personal especializado en competición debe ser capaz de motivar y apoyar a sus clientes en su preparación para los eventos deportivos, proporcionándoles consejos sobre nutrición, estrategias mentales y tácticas competitivas que mejoren sus resultados. También debe estar al tanto de las últimas tendencias y novedades en el mundo de la competición deportiva y ser capaz de incorporarlas en los programas de entrenamiento de sus clientes de manera efectiva. En resumen, la especialidad en competición de un entrenador personal implica la capacidad de diseñar programas de entrenamiento personalizados que preparen a sus clientes para competir en eventos deportivos y lograr sus objetivos competitivos, así como proporcionarles consejos sobre nutrición, estrategias mentales y tácticas competitivas que mejoren sus resultados.')),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Cerrar', style: TextStyle(color: Colors.red),),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }, 
                            child: Text('Más información')),
                            TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cerrar', style: TextStyle(color: Colors.red),),
                          ),
                        ],
                      );
                    },
                  );
                }, 
                icon: Image.network('https://res.cloudinary.com/djtofkkp9/image/upload/v1678725264/gipzep9tbusuuwixusty.png',width: 32, height: 32,),),
              if(widget.entrenador.especialidad.contains('competicion'))
              SizedBox(width: 15,),
              if(widget.entrenador.especialidad.contains('personalizado'))
              IconButton(
                onPressed: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        icon: Image.network('https://res.cloudinary.com/djtofkkp9/image/upload/v1678724618/gkldhyrdbucbiidsi58g.png', width: 64, height: 64,),
                        title: Text('Entrenamiento personalizado'),
                        content: Text('La especialidad en entrenamiento personalizado de un entrenador personal se refiere a su capacidad para diseñar programas de entrenamiento a medida para cada uno de sus clientes, teniendo en cuenta sus necesidades, objetivos, nivel de condición física actual, limitaciones físicas y cualquier otra consideración relevante.'),
                        actions: [
                          TextButton(
                            onPressed: (){
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    icon: Image.network('https://res.cloudinary.com/djtofkkp9/image/upload/v1678724618/gkldhyrdbucbiidsi58g.png', width: 64, height: 64,),
                                    content: SingleChildScrollView(child: Text('Un entrenador personal especializado en entrenamiento personalizado debe tener un conocimiento profundo en fisiología del ejercicio, nutrición, anatomía y biomecánica. Debe ser capaz de evaluar a cada uno de sus clientes para determinar su nivel de condición física y cualquier limitación física o lesión previa que puedan afectar su entrenamiento. A partir de la evaluación, el entrenador personal debe diseñar un programa de entrenamiento personalizado que se ajuste a las necesidades y objetivos de su cliente. Esto puede incluir una combinación de ejercicios de fuerza, cardiovasculares, movilidad y flexibilidad, así como también planes de nutrición y recuperación personalizados. El entrenador personal debe supervisar y ajustar el programa de entrenamiento a lo largo del tiempo para asegurarse de que sea efectivo y seguro para el cliente. También debe ser capaz de motivar y apoyar a su cliente para que se adhiera al programa de entrenamiento y logre sus objetivos de manera sostenible y duradera. En resumen, la especialidad en entrenamiento personalizado de un entrenador personal implica la capacidad de diseñar programas de entrenamiento a medida para cada uno de sus clientes, teniendo en cuenta sus necesidades, objetivos, nivel de condición física actual y limitaciones físicas. El entrenador personal debe supervisar y ajustar el programa de entrenamiento a lo largo del tiempo y motivar y apoyar a su cliente para lograr sus objetivos de manera sostenible y duradera.')),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Cerrar', style: TextStyle(color: Colors.red),),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }, 
                            child: Text('Más información')),
                            TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cerrar', style: TextStyle(color: Colors.red),),
                          ),
                        ],
                      );
                    },
                  );
                }, 
                icon: Image.network('https://res.cloudinary.com/djtofkkp9/image/upload/v1678724618/gkldhyrdbucbiidsi58g.png',width: 32, height: 32,),),
              if(widget.entrenador.especialidad.contains('personalizado'))
              SizedBox(width: 15,),
            ];
  }
}