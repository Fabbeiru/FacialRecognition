# FacialRecognition by Fabián Alfonso Beirutti Pérez
Game using facial recognition on processing.

## Introducción
El objetivo de esta práctica de la asignatura de 4to, Creación de Interfaces de Usuario (CIU), es empezar a tratar los conceptos y las primitivas del tratamiento de señales de entrada como imágenes y vídeos. Para ello, se ha pedido el desarrollo de una aplicación que a partir de una señal de entrada de vídeo, el usuario pueda interactuar de alguna manera con el proyecto. Todo ello, usando el lenguaje de programación y el IDE llamado Processing. Este permite desarrollar código en diferentes lenguajes y/o modos, como puede ser processing (basado en Java), p5.js (librería de JavaScript), Python, entre otros.
<p align="center"><img src="/facialRecognitionGif.gif" alt="Facial recognition using processing"></img></p>

Para la realización de esta práctica se ha usado también la aplicación llamada *FaceOSC* y la librería correspondiente en Processing *oscP5*. Esto, nos permite reconocer los movimientos de los elementos presentes en el rostro como la boca, ojos o cejas.

## Controles
Los controles de la aplicación se mostrarán en todo momento por pantalla para facilitar su uso al usuario:
- **Tecla R:** Reinicia el juego.
- **Movimiento de la cabeza:** Mueve la boca animada que representa al jugador.
- **Tecla ESC:** Cierre de la aplicación.

## Descripción
Aprovechando que el lenguaje de programación que utiliza el IDE Processing por defecto está basado en Java, podemos desarrollar nuestro código utilizando el paradigma de programación de "Programación Orientada a Objetos". Así pues, hemos descrito tres clases de Java:
- **FacialRecognition:** clase principal.
- **ParticleSystem:** clase que contiene a su vez, diversas clases anidadas que representan el objeto/resultado de crear un efecto de confeti.
- **Mouth:** clase que representa el objeto/resultado de enseñar por pantalla una imagen de una boca animada que se posiciona en función de los datos recogidos del reconocimiento facial de la aplicación llamada FaceOSC.
- **Bone:** clase que representa el objeto/resultado de crear uno de los elementos del juego y controles.
- **Pizza:** clase que representa el objeto/resultado de crear uno de los elementos del juego y controles.
- **Taco:** clase que representa el objeto/resultado de crear uno de los elementos del juego y controles.
- **Popcorn:** clase que representa el objeto/resultado de crear uno de los elementos del juego y controles.

## Explicación
### Clase FacialRecognition
Esta es la clase principal de la aplicación, la cual gestiona la información mostrada por pantalla al usuario (interfaz gráfica), esto es, el desarrollo de los métodos setup() y draw().
```java
void setup() {
  size(640, 480);
  frameRate(45);
  smooth(); 
  font = loadFont("Consolas-Italic-48.vlw");
  textFont(font);
  
  mouth = new Mouth();
  bone = new Bone();
  pizza = new Pizza();
  popcorn = new Popcorn();
  taco = new Taco();
  
  startGame = false;
  victory = false;
  menu = true;
  particleAdded = false;

  // FaceOSC
  oscP5 = new OscP5(this, 8338);
  oscP5.plug(this, "mouthWidthReceived", "/gesture/mouth/width");
  oscP5.plug(this, "mouthHeightReceived", "/gesture/mouth/height");
  oscP5.plug(this, "found", "/found");
  oscP5.plug(this, "poseOrientation", "/pose/orientation");
  oscP5.plug(this, "posePosition", "/pose/position");
  oscP5.plug(this, "poseScale", "/pose/scale");

  imageMode(CENTER);
  textAlign(CENTER, CENTER);
  rectMode(CENTER);
  noStroke();
  fill(0);
  textSize(20);
  
  systems = new ArrayList<ParticleSystem>();
  eat = new SoundFile(this, "score.wav");
  wrongFood = new SoundFile(this, "hit.wav");
}

void draw() {
  if (menu) menu();
  else {
    background(120);
    showHelp();
    initFood();
    if (victory) victoryScreen();
    if (!found) errorScreen();
  }
}
```
Como se puede ver, en la función *setup()*, cargamos e inicializamos todas las variables y objetos que vamos utilizar a lo largo del programa. Además, en la función *draw()*, controlamos, según los valores de variables booleanas que se manejan según la interacción del usuario con la aplicación, que pantallas se muestran por pantalla como puede ser el menú, el juego o la pantalla de victoria.

Por otra parte, esta misma clase es la que maneja la interacción entre el usuario y la interfaz mediante la implementación de los métodos keyPressed(), keyReleased(), mousePressed(), entre otros. Un ejemplo se muestra a continuación:
```java
void keyPressed() {
  if (keyCode == ENTER) menu = false;
  if (key == 'R' || key == 'r') {
    victory = false;
    resetGame();
    systems.clear();
  }
}
```

### Clase Mouth
La clase Mouth representa al objeto de la imagen de una caricatura de una boca que se posiciona en función de los valores que se reciben de la aplicación *FaceOSC*.
```java
void mouthControls() {
  if (found) {
    image(mouth, (0-posePosition.x)+width, posePosition.y-mouthHeight*4, mouthWidth*10, mouthHeight+50);
  }
}
```

### Clase Taco
La estructura de la clase Taco, Pizza, Popcorn y Bone es similar. Todas tienen su constructor, método Controls() y Reset(), siendo estos dos úlitmos propios de cada clase/objeto, consiguiendo así unas características y movimientos diferentes para cada uno de ellos.
```java
void tacoControls() {
  image(taco, xtPos, ytPos, 80, 75);

  xtPos = xtPos + xtSpeed;
  ytPos = ytPos + ytSpeed;

  if ((xtPos > width) || (xtPos < 0)) {
    xtSpeed = xtSpeed * -1;
  }

  if ((ytPos > height) || (ytPos < 0)) {
    ytSpeed = ytSpeed * -1;
  }

  if (found) {
    if ((xtPos<=(0-posePosition.x)+width+mouthWidth*4) && (xtPos>=(0-posePosition.x)+width - mouthWidth*5) && (ytPos<=posePosition.y+mouthHeight*4) && (ytPos>=posePosition.y-mouthHeight*4)) {
      tacoReset();
      xtPos = xtReset;
      ytPos = ytReset;
      thread ("eat");
      score+= 1;
    }
  }
}
  
void tacoReset() {
  xtReset = random(450);
  ytReset = random(450);
}
```

## Descarga y prueba
Para poder probar correctamente el código, descargar los ficheros (el .zip del repositorio) y en la carpeta llamada FacialRecognition se encuentran los archivos de la aplicación listos para probar y ejecutar. El archivo "README.md" y aquellos fuera de la carpeta del proyecto (FacialRecognition), son opcionales, si se descargan no deberían influir en el funcionamiento del código ya que, son usados para darle formato a la presentación y explicación del repositorio en la plataforma GitHub.

Adicionalmente, dado que se ha usado una aplicación adicional en esta práctica, para probarla será necesario:
- Añadir e importar la librería *oscP5* en Processing.
- Tener instalado y ejecutar a la vez que el código principal la aplicación *FaceOSC*.

## Recursos empleados
Para la realización de este sistema planetario en 3D, se han consultado y/o utilizado los siguientes recursos:
* Guión de prácticas de la asignatura CIU
* <a href="https://processing.org">Página de oficial de Processing y sus referencias y ayudas</a>
* Processing IDE
* Aplicación <a href="https://github.com/kylemcdonald/ofxFaceTracker/releases">FaceOSC</a> de Kyle McDonald.
* <a href="https://github.com/CreativeInquiry/FaceOSC-Templates">Ejemplos de uso</a> de FaceOSC
* Cámara o webcam.

Por otro lado, las librerías empleadas fueron:
* <a href="https://github.com/extrapixel/gif-animation">GifAnimation</a> de Patrick Meister.
* oscP5 de Andreas Schlegel.
