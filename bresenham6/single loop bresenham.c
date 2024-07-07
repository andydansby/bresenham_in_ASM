


//http://members.chello.at/~easyfilter/bresenham.html

void plotLine(int x1, int y1, int x2, int y2)
{
	int deltaX =  abs(x2-x1);
	int stepX = x1 < x2 ? 1 : -1;
	int deltaY = -abs(y2-y1);
	int stepY = y1 < y2 ? 1 : -1; 
	int error1 = deltaX + deltaY;
	int error2; /* error value e_xy */
 
	for(;;)
	{  /* loop */

		setPixel(x1,y1);
	  
		if (x1==x2 && y1==y2) break;
	  
		error2 = 2 * error1;
	  
		if (error2 >= deltaY) //deltaY case
		{ 
			error1 += deltaY;
			x1 += stepX;
		} /* e_xy+e_x > 0 */
	  
		if (error2 <= deltaX)//deltaX case
		{
			error1 += deltaX;
			y1 += stepY;
		} /* e_xy+e_y < 0 */
	}
}






















//convert this
void plotLine(int x1, int y1, int x2, int y2)
{
	int stepX = x1 < x2 ? 1 : -1;
	int stepY = y1 < y2 ? 1 : -1;
	
    int deltaX = abs(x2 - x1);    
    int deltaY = -abs(y2 - y1);
    
    int error1 = deltaX + deltaY;
	int error2;   
    
    while (1)
	{
        //plot(x1, y1)
        if (x1 == x2 && y1 == y2)
		{
			break;
		}
		
		
        error2 = 2 * error1;
		
		//deltaY case
        if (error2 >= deltaY)
		{
            if (x1 == x2) 
			{
				break;
			}
            error1 = error1 + deltaY;
            x1 = x1 + stepX;
		}//end if
		
		//deltaX case
        if (error2 <= deltaX)
		{
            if (y1 == y2)
			{
				break;
			}
            error1 = error1 + deltaX;
            y1 = y1 + stepY;
        }//end if
		
    }	//end while
}


void line(int x1, int y1, int x2, int y2)
{
    int dx = abs(x2 - x1);
    int dy = abs(y2 - y1);
    int stepx = x1 < x2 ? 1 : -1;
    int stepy = y1 < y2 ? 1 : -1;
    int error1 = dx - dy;
	int error2 = 0;

    while (1)
	{
        printf("(%d, %d)\n", x1, y1);
		//plot x1,y1
		// Output the current point
        if (x1 == x2 && y1 == y2) 
		{
            break;
        }
        error2 = 2 * error1;
        if (error2 > -dy)
		{
            error1 -= dy;
            x1 += stepx;
        }
        if (error2 < dx)
		{
            error1 += dx;
            y1 += stepy;
        }
		
    }
}
