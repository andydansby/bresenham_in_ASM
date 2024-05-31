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