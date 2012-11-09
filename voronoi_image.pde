import toxi.processing.*;
import toxi.geom.mesh2d.*;
import toxi.geom.*;

ToxiclibsSupport gfx;
Voronoi voronoi;
PImage img;
String imageName = "hanging_feet.jpg";

void setup()
{
    img = loadImage(imageName);
    size(img.width,img.height);
    gfx = new ToxiclibsSupport(this);
    
    voronoi = new Voronoi();
    // number of voronoi regions to be created.
    int pts = width*3+height;
    for ( int i = 0; i &lt; pts; i++ ) {
        voronoi.addPoint(new Vec2D(random(width), random(height)));
    }
    // we do not require to loop draw().
    noLoop();
}

void draw()
{
    color[] colors = new color[voronoi.getSites().size()];
    for ( Polygon2D polygon : voronoi.getRegions() ) {
        for ( Vec2D v : voronoi.getSites() ) {
            if ( polygon.containsPoint( v ) ) {
                // get the color at current voronoi site &amp; fill the region.
                fill(img.get(int(v.x), int(v.y)));
                gfx.polygon2D(polygon);
            }
        }
    }
    saveFrame("images/voronoi_"+imageName);
}
