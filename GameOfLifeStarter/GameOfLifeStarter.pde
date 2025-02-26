final int SPACING = 20; // each cell's width/height //<>// //<>//
final float DENSITY = 0.5; // how likely each cell is to be alive at the start
int[][] grid; // the 2D array to hold 0's and 1's
int draw =0;

void setup() {
  size(1000, 800); // adjust accordingly, make sure it's a multiple of SPACING
  noStroke(); // don't draw the edges of each cell
  frameRate(5); // controls speed of regeneration
  grid = new int[height / SPACING][width / SPACING *2];
  // populate initial grid
  // your code here
  for (int i =0; i <grid.length; i++) {
    for (int j =0; j <grid[0].length-1; j++) {
      if (j%2 ==0 && Math.random() <=DENSITY) {
        grid [i][j] =1;
      } else {
        grid [i][j] =0;
      }
    }
  }
}

void draw() {
  showGrid();
  grid = calcNextGrid();
}

void mousePressed() {
  if (draw ==0) {
    noLoop();
    draw++;
  } else {
    draw =0;
    loop();
  }
}

int[][] calcNextGrid() {
  int count =0;
  int[][] nextGrid = new int[grid.length][grid[0].length];
  for (int i =0; i <grid.length; i++) {
    for (int j =0; j <grid[0].length; j+=2) {
      count = countNeighbors(i, j);
      if (count ==3) {
        nextGrid[i][j] =1;
        if (grid[i][j] ==1) {
          nextGrid[i][j+1] = grid[i][j+1]+1;
        }
      } else if (count ==2 && grid[i][j] ==1) {
        nextGrid[i][j] =1;
        nextGrid[i][j+1] = grid[i][j+1] +1;
      } else {
        nextGrid[i][j] =0;
        nextGrid[i][j+1] =0;
      }
    }
  }
  return nextGrid;
}

int countNeighbors(int i, int j) {
  int count =0;
  if (i>0) {
    count += grid[i-1][j];
  }
  if (i <grid.length -1) {
    count += grid[i+1][j];
  }
  if (j <grid[0].length -2) {
    count += grid[i][j+2];
  }
  if (j>0) {
    count += grid[i][j-2];
  }
  if (j>0 && i>0) {
    count += grid[i-1][j-2];
  }
  if (j <grid[0].length -2 && i>0) {
    count += grid[i-1][j+2];
  }
  if (j <grid[0].length -2 && i<grid.length -1) {
    count += grid[i+1][j+2];
  }
  if (j>0 && i <grid.length -1) {
    count += grid[i+1][j-2];
  }
  return count;
}

void showGrid() {
  color bright =color(255, 204, 0);
  color dark = color(0, 0, 139);
  color light = color(220, 215, 0);
  color medium = color (190, 127, 0);
  color superDark = color (7, 7, 7);
  background(255);
  for (int i=0; i <grid.length; i++) {
    for (int j=0; j <grid[0].length; j+=2) {
      if (grid[i][j]==1 && grid[i][j+1]==1) {
        fill(light);
        square(j* SPACING /2, i* SPACING, SPACING);
      } else if (grid[i][j] ==1 && grid[i][j+1] ==3) {
        fill(medium);
        square(j* SPACING /2, i* SPACING, SPACING);
      } else if (grid[i][j] ==1 && grid[i][j+1] ==5) {
        fill(dark);
        square(j* SPACING /2, i *SPACING, SPACING);
      } else if (grid[i][j] ==1 && grid[i][j+1] >5) {
        fill(superDark);
        square(j* SPACING /2, i* SPACING, SPACING);
      } else if (grid[i][j] ==1) {
        fill(bright);
        square(j* SPACING /2, i* SPACING, SPACING);
      }
    }
  }
}
