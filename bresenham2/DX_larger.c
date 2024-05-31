if (dx > dy)
{//dx larger functin
	int fraction = 2 * dy - dx; //answer @ $920A
	//(2 * dy) - dx

	while (x != x2)				//decision @ $920D
	{
		x += stepx;				//answer @ $9221
		if (fraction >= 0)		//decision from $922E to $9234
								//equal to 0 @ $922E
								//greater than 0 @ $9231
								//less than 0 @ $9234
		{
			y += stepy;			//answer @ $9245
			fraction -= 2 * dx;	//answer @ $9253 
		}//end if				//@$9256	loops back to see if fraction is >= 0
		fraction += 2 * dy;
		//plot x,y
	}//end while
}//end if