// Establecer variables
Table table;
int rowNumber;

PFont font1;
PFont font2;


void setup() {
  size (900, 700);
  table =loadTable ("Chocolate_Sales.csv", "header");
  println (table. getRowCount() + "total de filas en la tabla");

  font1 = loadFont("AstonScriptBold-Bold-70.vlw");
  font2 = loadFont("BowtarisRegular-50.vlw");
}

void draw() {
  background(236, 218, 206);

  // Dibujar texto
  fill(108, 11, 44);
  textFont(font1);
  textSize(50);
  text("Chocolate", 60, 80);

  fill(108, 11, 44);
  textFont(font2);
  textSize(30);
  text("Sales Data", 140, 110);

  // Dibujar barras
  rowNumber = 0;
  for (TableRow row : table.rows()) {
    String Product = row.getString("Product");
    int BoxesShipped = row.getInt("Boxes Shipped");

    // Solo mostrar si las ventas son mayores a 500
    if (BoxesShipped > 500) {
      noStroke();
      fill(101, 52, 37);
      rect(rowNumber * 60, height - 30 - BoxesShipped * 0.5, 40, BoxesShipped * 0.5);
      rowNumber++;
    }
  }
}
