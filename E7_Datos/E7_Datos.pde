// Establecer variables
Table table;
ArrayList<String> dates; // Lista de fechas únicas
int currentDateIndex = 0; // Para mostrar solo los datos de una fecha a la vez
int clickedProductIndex = -1; // Para almacenar el índice del producto seleccionado
int selectedBarIndex = -1; // Variable de la barra seleccionada

// Variables de fuentes
PFont font1;
PFont font2;
PFont font3;

void setup() {
  size(1500, 700);

  // Cargar tabla
  table = loadTable("Chocolate_Sales.csv", "header");
  println(table.getRowCount() + " total de filas en la tabla");

  // Cargar fuentes
  font1 = loadFont("AstonScriptBold-Bold-70.vlw");
  font2 = loadFont("BowtarisRegular-50.vlw");
  font3 = loadFont("GillSansMT-Condensed-50.vlw");

  // Extraer fechas únicas
  dates = new ArrayList<String>();
  for (TableRow row : table.rows()) {
    String date = row.getString("Date");
    // Para Filtrar los datos según la fecha actual
    if (!dates.contains(date)) {
      dates.add(date);
    }
  }
  println("Fechas disponibles: " + dates);
}


void draw() {
  background(236, 218, 206);

  // Dibujar ornamentos
  stroke(108, 11, 44);
  strokeWeight(2);
  line(60, 120, 330, 120);

  // Dibujar titulo
  fill(108, 11, 44);
  textFont(font1);
  textSize(50);
  text("Chocolate", 60, 80);

  fill(108, 11, 44);
  textFont(font2);
  textSize(30);
  text("Sales Data", 140, 110);

  // Dibujar fecha actual
  fill(108, 11, 44);
  textSize(20);
  text("Fecha: " + dates.get(currentDateIndex), 60, 250);

  // Dibujar instrucciones
  fill(108, 11, 44);
  textSize(20);
  textAlign(LEFT);
  text(" Izquierda: Fecha anterior\n Derecha: Fecha siguiente\n Click en barra: Mostrar ventas", 55, 160);

  // Dibujar barras
  int productIndex = 0;
  for (TableRow row : table.rows()) {
    String date = row.getString("Date");
    if (date.equals(dates.get(currentDateIndex))) {
      String product = row.getString("Product");
      int boxesShipped = row.getInt("Boxes Shipped");

      noStroke();
      if (productIndex == selectedBarIndex) {
        fill(197, 163, 125);  // Color para la barra seleccionada
      } else {
        fill(71, 44, 37);  // Color normal
      }
      float barHeight = boxesShipped * 0.5; // Escalar altura
      rect(20 + productIndex * 100, height - 100 - barHeight, 40, barHeight);

      // Dibujar nombre del producto
      fill(71, 44, 37);
      textFont(font3);
      textSize(14);
      text(product, 20 + productIndex * 100, height - 80);

      // Si la barra fue seleccionada, mostrar el número de cajas
      if (productIndex == clickedProductIndex) {
        fill(197, 163, 125);
        textFont(font2);
        textSize(20);
        text(boxesShipped, 20 + productIndex * 100, height - 100 - barHeight - 10);
      }

      productIndex++;
    }
  }
}

void keyPressed() {
  // Flecha derecha: avanzar fecha
  if (keyCode == RIGHT) {
    currentDateIndex++;
    if (currentDateIndex >= dates.size()) {
      currentDateIndex = 0; // Vuelve al inicio
    }
  }
  // Flecha izquierda: retroceder fecha
  if (keyCode == LEFT) {
    currentDateIndex--;
    if (currentDateIndex < 0) {
      currentDateIndex = dates.size() - 1; // Va al final
    }
  }
}

void mousePressed() {
  int productIndex = 0;
  selectedBarIndex = -1;
  clickedProductIndex = -1;  // Resetear clic

  for (TableRow row : table.rows()) {
    String date = row.getString("Date");
    if (date.equals(dates.get(currentDateIndex))) {
      int boxesShipped = row.getInt("Boxes Shipped");
      float barHeight = boxesShipped * 0.5;

      // Usa las MISMAS coordenadas que en draw()
      float x = 20 + productIndex * 100;
      float y = height - 100 - barHeight;

      if (mouseX > x && mouseX < x + 40 && mouseY > y && mouseY < y + barHeight) {
        selectedBarIndex = productIndex;   // Para cambiar color
        clickedProductIndex = productIndex; // Para mostrar número de ventas
      }

      productIndex++;
    }
  }
}
