class Node {
  PVector pos, vel;
  PVector org;
  float s, n;
  
  Node(float x, float y, float z){
    pos = new PVector(x, y, z);
    org = new PVector(x, y, z);
    vel = new PVector(0, 0, 0);
    s = map(noise(x,y,z), 0, 1, 2, 5);
  }
  void reset(){
    pos = org.copy();
  }
  void display(){
    //stroke(pos.z, 255, 255);
    stroke((0.2*pos.z+0.2*pos.x+0.2*pos.y)%256, 255, 255, map(pos.z, -125, 300, 0, 255));
    //strokeWeight(15);
    strokeWeight(map(pos.z, -300, 300, 0, 25));
    //stroke();
    point(pos.x, pos.y, pos.z);
  }
  void update(){
    float theta = 5.33 * map(noise(pos.x/250, pos.y/250), 0, 1, -1, 1);
    float phi = 5.33 * map(noise(pos.x/250, pos.y/250, pos.z/250), 0, 1, -1, 1);
    vel.x = 0.07*cos(theta)*cos(phi);
    vel.y = 0.07*sin(theta)*sin(phi);
    vel.z = 0.07*sin(phi);
    pos.add(vel);
  }
}
    