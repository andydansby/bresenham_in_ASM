void bresenham_clean(int xx1, int yy1, int xx2, int yy2)
{
	int delta_x;//signed
	int delta_y;//signed
	int stepx;//signed
	int stepy;//signed
	int fraction;//signed

	delta_x = xx2 - xx1;
	stepx = (delta_x < 0) ? -1 : 1;
			
	delta_y = yy2 - yy1;
	stepy = (delta_y < 0) ? -1 : 1;

	delta_x = Math.Abs(delta_x);
	delta_y = Math.Abs(delta_y);


	//plot starting point
	//buffer_plotX = xx1;
	//buffer_plotY = yy1;
	//buffer_plot();

	if (delta_x > delta_y)
	{
		fraction = delta_y - (delta_x >> 1);
		while (xx1 != xx2)
		{
			//buffer_plotX = xx1;
			//buffer_plotY = yy1;
			//buffer_plot();
			//buffer_point();

			if (fraction >= 0)
			{
				yy1 += stepy;
				fraction -= delta_x;
			}
			xx1 += stepx;
			fraction += delta_y;
		}//end while
	}//end if
	else
	{
		fraction = delta_x - (delta_y >> 1);
		while (yy1 != yy2)
		{
			//buffer_plotX = xx1;
			//buffer_plotY = yy1;
			//buffer_plot();
			//buffer_point();

			if (fraction >= 0)
			{
				xx1 += stepx;
				fraction -= delta_y;
			}
			yy1 += stepy;
			fraction += delta_x;
		}//end while
	}//end else
}//end routine