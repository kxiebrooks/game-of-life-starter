final int SPACING = 20; // each cell's width/height //<>// //<>//
final float DENSITY = 0.5; // how likely each cell is to be alive at the start
int[][] grid; // the 2D array to hold 0's and 1's

void setup() {
  size(2000, 1000); // adjust accordingly, make sure it's a multiple of SPACING
  noStroke(); // don't draw the edges of each cell
  frameRate(10); // controls speed of regeneration
  grid = new int[height / SPACING][width / SPACING];
  // populate initial grid
  // your code here
  for (int i =0; i<grid.length; i++) {
    for (int j =0; j<grid[0].length; j++) {
      if (random(1/DENSITY/DENSITY)<=1/DENSITY) {
        grid [i][j]=1;
      } else {
        grid[i][j]=0;
      }
    }
  }
}

void draw() {
  showGrid();
  grid = calcNextGrid();
}


int[][] calcNextGrid() {
  int count =0;
  int[][] nextGrid = new int[grid.length][grid[0].length];
  for (int i=0; i<grid.length; i++) {
    for (int j=0; j<grid[0].length; j++) {
      count = countNeighbors(i, j);
      if (count ==3) {
        nextGrid[i][j]=1;
      } else if (count==2&&grid[i][j]==1) {
        nextGrid[i][j]=1;
      } else {
        nextGrid[i][j]=0;
      }
    }
  }

  // your code here


  return nextGrid;
}

int countNeighbors(int i, int j) {
  int count = 0;
  if (i!=0) {
    count += grid[i-1][j];
  }
  if (i!=grid.length-1) {
    count += grid[i+1][j];
  }
  if (j!=grid[0].length-1) {
    count += grid[i][j+1];
  }
  if (j!=0) {
    count += grid[i][j-1];
  }
  if (j!=0&&i!=0) {
    count += grid[i-1][j-1];
  }
  if (j!=grid[0].length-1&&i!=0) {
    count += grid[i-1][j+1];
  }
  if (j!=grid[0].length-1&&i!=grid.length-1) {
    count += grid[i+1][j+1];
  }
  if (j!=0&&i!=grid.length-1) {
    count += grid[i+1][j-1];
  }
  return count;
}

void showGrid() {
  color bright =color(255, 204, 0);
  background(255);
  for (int i=0; i<grid.length; i++) {
    for (int j=0; j<grid[0].length; j++) {
      if (grid[i][j]==1) {
        fill(bright);
        square(j*SPACING, i*SPACING, SPACING);
      }
    }
  }
}
