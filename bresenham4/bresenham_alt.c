
void bresenham (int xx1, int yy1, int xx2, int yy2)
{
    delta_y1 = yy2 - yy1;
    delta_x1 = xx2 - xx1;

    stepy = (delta_y1 < 0) ? -1 : 1;
    stepx = (delta_x1 < 0) ? -1 : 1;

    delta_x1 = ABS(delta_x1);
    delta_y1 = ABS(delta_y1);

	//plot starting point
    buffer_plotX = xx1;
    buffer_plotY = yy1;
    buffer_plot();

    if (delta_x1 > delta_y1)
    {
        fraction = delta_y1 - (delta_x1 >> 1);
        while (xx1 != xx2)
        {
            buffer_plotX = xx1;
            buffer_plotY = yy1;
            buffer_plot();
            //buffer_point();

            if (fraction >= 0)
            {
                yy1 += stepy;
                fraction -= delta_x1;
            }
            xx1 += stepx;
            fraction += delta_y1;
        }//end while
    }//end if
    else
    {
        fraction = delta_x1 - (delta_y1 >> 1);
        while (yy1 != yy2)
        {
            buffer_plotX = xx1;
            buffer_plotY = yy1;
            buffer_plot();
            //buffer_point();

            if (fraction >= 0)
            {
                xx1 += stepx;
                fraction -= delta_y1;
            }
            yy1 += stepy;
            fraction += delta_x1;
        }//end while
    }//end else

}