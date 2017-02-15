use strict;
use SVG;
## Columnas sustratos bien..
##perl read_mydata.pl mydata.cvs>Heat.colors
## Once we manually add names for anzymes and substrates to RGB color matriz

## Insertar árbol
    # create an SVG object with a size of 40x40 pixels
my $svg = SVG->new(  	
			width  => 1000,	height => 1000, onload=>'Init(evt)',onmousemove=>' GetTrueCoords(evt); ShowTooltip(evt, true)',
   			onmouseout=>'ShowTooltip(evt, false)'
			);
my $tag = $svg->script(-type=>"text/ecmascript");
## Me gustaria dar un renglon y una coordenada y que lo dibuje ## O sea que cada renglon fuera un data

## Y coords
my $file=$ARGV[0]; ## Matrix Data ## row enzymes # column substrates ## row enzymes
#perl readTree.pl con_50_majrule.svg >COORDY coordinates 
my $coord=$ARGV[1];
my %YCOORD;
readCoord($coord,\%YCOORD);
	# Read data matrix
my @DATA;


readData($file,\@DATA);
my $Colsize = scalar@{$DATA[0]};
my $Rowsize = scalar @DATA ;
# print "Columns $Colsize Rows=$Rowsize\n";



for (my $row=1; $row<$Rowsize;$row++){
	for(my $col=1; $col<$Colsize;$col++){
		my $enzyme=$DATA[$row][0];
		#print "enzyme $enzyme\n";
		my $val=$DATA[$row][$col];
		my $y=$YCOORD{$enzyme};
		my $x=(10)*int($col);
		my $color=$val ;
		my $substrate=$DATA[0][$col];
			DrawSquare($row,$col,$x,$y,$color);  ## row -> y column -> x
		#print "Pause at DrawSquare($row,$col,$x,$y,$color)";
		#my $pAuse=<STDIN>;
		
		}	
	}

tipTools();
 ######################################################################################

sub tipTools{
	for (my $i=1; $i<$Rowsize;$i++){
		for(my $j=1; $j<$Colsize;$j++){
			my $val=$DATA[$i][$j];
			my $enzyme=$DATA[$i][0];
			my $substrate=$DATA[0][$j];
			my $y=$YCOORD{$enzyme};
			my $x=(10)*int($i);

#			print " j,i $j, $i, \n";
#			my $pause1=<STDIN>;
#			print " x, y $x, $y, \n";
#			my $pause2=<STDIN>;
#			print "enzyme $enzyme, \n";
#			my $pause3=<STDIN>;
#			print "Substrate $substrate:\n";
#			my $pause4=<STDIN>;
#			print "val $val \n";
#			my $pause5=<STDIN>;
	
		
			open (DRAW,"HeatPlot.svg") or die $!;
			open (TEMP,">HeatPlot.svg.temp") or die $!;
			foreach my $line (<DRAW>){
				chomp $line;
				if($line=~m/\"$i#$j\"/){
					#	print "$line\n";
					$line=~s/title=\"$i#$j\"//;
					#	print "$line\n";
					$line=~s/\/\>$/\>\n\<title\>Enz: $enzyme, Subs: $substrate Val:$val, \<\/title\>\<\/rect\>/;
					#	print "$line\n\n";
					}
				print TEMP "$line\n"; 
				}
			close DRAW;
			close TEMP;
			`mv HeatPlot.svg.temp HeatPlot.svg`;
			}
		}
	}
#_______________________________________________________________________
#______________________________________________________-

sub readData{
	my $file=shift;
	my $refDATA=shift;
	open (FILE,$file) or die $!;
	my $rows=0;
	foreach my $line (<FILE>){
		chomp $line;
		#print "line $line\n";
		@{$refDATA->[$rows]}=split(/\t/,$line);
		#print "Enzyme $refDATA->[$rows][0]\n";
		#print "pause";
		#my $pause ="<STDIN>";
		$rows++;
		}
	close FILE;
}

#__________________________________________________________________________________
sub DrawSquare{
	my $i=shift; #row y
	my $j=shift; #column x

	my $x=shift; #row y
	my $y=shift; #column x
	my $color=shift;

#	print "j,i $j,$i -> x,y $x,$y Val $val\n";
	# create a rectangle (actually square) with the top left
	# corner being at (40, 50)
	# (0, 0) would mean being in the top left corner of the image.
	# The width and the height of the rectangular are also given
	# in pixels and we can add style just asw we  did with the circle.
	$svg->rectangle(
	    x => $x,
	    y => $y,
		
	    width  => 10,
	    height => 10,
	    style => {
        	'fill'           => "$color",
	        'stroke'         => 'black',
        	'stroke-width'   =>  1,
	        'stroke-opacity' =>  1,
        	'fill-opacity'   =>  1,
   		},
            title   =>  "$i#$j",
	);
	open (OUT, ">HeatPlot.svg") or die "Couldn't open HeatPlot.svg \n$!";
	# now render the SVG object, implicitly use svg namespace
	print OUT $svg->xmlify;
	close OUT;
	
};
 
##############################################################################

$tag->CDATA(qq{
         var SVGDocument = null;
      var SVGRoot = null;
      var SVGViewBox = null;
      var svgns = 'http://www.w3.org/2000/svg';
      var xlinkns = 'http://www.w3.org/1999/xlink';
      var toolTip = null;
      var TrueCoords = null;
      var tipBox = null;
      var tipText = null;
      var tipTitle = null;
      var tipDesc = null;
      var lastElement = null;
      var titleText = '';
      var titleDesc = '';
      function Init(evt)
      {
         SVGDocument = evt.target.ownerDocument;
         SVGRoot = document.documentElement;
         TrueCoords = SVGRoot.createSVGPoint();
         toolTip = SVGDocument.getElementById('ToolTip');
         tipBox = SVGDocument.getElementById('tipbox');
         tipText = SVGDocument.getElementById('tipText');
         tipTitle = SVGDocument.getElementById('tipTitle');
         tipDesc = SVGDocument.getElementById('tipDesc');
      };
      function GetTrueCoords(evt)
      {
         // find the current zoom level and pan setting, and adjust the reported
         //    mouse position accordingly
         var newScale = SVGRoot.currentScale;
         var translation = SVGRoot.currentTranslate;
         TrueCoords.x = (evt.clientX - translation.x)/newScale;
         TrueCoords.y = (evt.clientY - translation.y)/newScale;
      };
      function ShowTooltip(evt, turnOn)
      {
         try
         {
            if (!evt || !turnOn)
            {
               toolTip.setAttributeNS(null, 'display', 'none');
            }
            else
            {
               var tipScale = 1/SVGRoot.currentScale;
               var textWidth = 0;
               var tspanWidth = 0;
               var boxHeight = 20;
               tipBox.setAttributeNS(null, 'transform', 'scale(' + tipScale + ',' + tipScale + ')' );
               tipText.setAttributeNS(null, 'transform', 'scale(' + tipScale + ',' + tipScale + ')' );
               var targetElement = evt.target;
               if ( lastElement != targetElement )
               {
                  var targetTitle = targetElement.getElementsByTagName('title').item(0);
                  if ( targetTitle )
                  {
                     titleText = targetTitle.firstChild.nodeValue;
                     tipTitle.firstChild.nodeValue = titleText;
                  }
                  var targetDesc = targetElement.getElementsByTagName('desc').item(0);
                  if ( targetDesc )
                  {
                     titleDesc = targetDesc.firstChild.nodeValue;
                     tipDesc.firstChild.nodeValue = titleDesc;
                  }
               }
               var xPos = TrueCoords.x + (10 * tipScale);
               var yPos = TrueCoords.y + (10 * tipScale);
               //return rectangle around object as SVGRect object
               var outline = tipText.getBBox();
               tipBox.setAttributeNS(null, 'width', Number(outline.width) + 10);
               tipBox.setAttributeNS(null, 'height', Number(outline.height) + 10);
               toolTip.setAttributeNS(null, 'transform', 'translate(' + xPos + ',' + yPos + ')');
               toolTip.setAttributeNS(null, 'display', 'inline');
            }
         }
         catch(er){}
       };
}); 
#____________________________________________________________________________________
sub readCoord{
	# key JODS01 value numerical hash
	my $coord=shift;
	my $refCOORD=shift;

	open (COORD,$coord)or die $!;
	foreach my $line(<COORD>){
		#print "line $line\n";
		chomp $line;
		my@st=split('\t',$line);
		$refCOORD->{$st[1]}=$st[0];
		print "$refCOORD->{$st[1]}=$st[0]\t$st[1]\n";
		}
	close COORD;
}
