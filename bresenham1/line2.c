void bresenham(int x1, int y1, int x2, int y2)
{
	int dx = Math.Abs(x2 - x1);
	int dy = Math.Abs(y2 - y1);
	int stepx = (x1 < x2) ? 1 : -1;
	int stepy = (y1 < y2) ? 1 : -1;

	int x = x1;
	int y = y1;
	//plot x,y

	if (dx > dy)
	{//dx larger functin
		int fraction = 2 * dy - dx; //(2 * dy) - dx

		while (x != x2)
		{
			x += stepx;
			if (fraction >= 0)
			{
				y += stepy;
				fraction -= 2 * dx;
			}//end if
			fraction += 2 * dy;
			//plot x,y
		}//end while
	}//end if
	//else
	if (dy >= dx) 
	{
		int fraction = 2 * dx - dy;// (2 * dx) - dy

		while (y != y2)
		{
			y += stepy;
			if (fraction >= 0)
			{
				x += stepx;
				fraction -= 2 * dy;
			}//end if
			fraction += 2 * dx;
			//plot x,y
		}//end while
	}//end else
}