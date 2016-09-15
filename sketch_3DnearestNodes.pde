int rows, cols;
int aisl;
float dis = 25;
Node[][][] nodes;
float ny, nx, nz = 0;
float zoom = 0;

void setup() {
  size(500, 750, P3D);
  colorMode(HSB);
  pixelDensity(displayDensity());
  rows = floor(width/dis) + 5;
  cols = floor(height/dis) + 5;
  aisl = 5;
  nodes = new Node[rows][cols][aisl];
  for (int x = 0; x < rows; x++) {
    for (int y = 0; y < cols; y++) {
      for (int z = 0; z < aisl; z++) {
        nodes[x][y][z] = new Node(x*dis, y*dis, z*dis*2);
      }
    }
  }
  background(255);
}

void mouseClicked() {
  println(nodes[1][1][3].pos.z);
}

void keyPressed() {
  noiseSeed((long) random(100000));
  if (key == 'z'){
    zoom += 25;
  }
  if (key == 'm'){
    zoom -= 25;
  }
  if (key == 'r') {
    for (int x = 0; x < rows; x++) {
      for (int y = 0; y < cols; y++) {
        for (int z = 0; z < aisl; z++) {
          nodes[x][y][z].reset();
        }
      }
    }
  }
}

void draw() {
  //println(frameRate);
  //translate(0, 0, map(mouseX, 0, width, -150, 500));
  translate(width/2, height/2, -zoom);
  rotateX(map(mouseX, 0, width, 0, HALF_PI));
  translate(-width/3.5, -height/4, zoom);
  scale(0.5);
  //rotateY(radians(ny+=0.1));
  //rotateX(radians(nx+=0.1));
  //rotateZ(radians(nz+=0.1));
  background(255);
  //background(0);
  for (int x = 0; x < rows; x++) {
    for (int y = 0; y < cols; y++) {
      for (int z = 0; z < aisl; z++) {
        Node n1 = nodes[x][y][z];

        stroke(0, 175);
        //stroke(255, 175);
        strokeWeight(n1.pos.z);
        strokeWeight(map(nodes[x][y][z].pos.z, 0, 300, 0, 1));
        if (x > 0) {
          Node n2 = nodes[x-1][y][z];
          line(n1.pos.x, n1.pos.y, n1.pos.z, n2.pos.x, n2.pos.y, n2.pos.z);
        }
        if (y > 0) {
          Node n2 = nodes[x][y-1][z];
          line(n1.pos.x, n1.pos.y, n1.pos.z, n2.pos.x, n2.pos.y, n2.pos.z);
        }
        if (z > 0) {
          Node n2 = nodes[x][y][z-1];
          line(n1.pos.x, n1.pos.y, n1.pos.z, n2.pos.x, n2.pos.y, n2.pos.z);
        }
        nodes[x][y][z].display();
        nodes[x][y][z].update();
      }
    }
  }
}