void setup() {
    size(1024, 576, P3D);
    textFont(createFont("Arial", 64));
}

void draw() {
    background(0);
    camera(0, 0, 100, 0, 0, 0, 0, 1, 0);
    float time = millis() / 1000.0f;

    stroke(255);
    strokeWeight(0.05f);
    float radius = 20;
    for (int i = 0; i <= 3; i++) {
        float x = (i - 1.5f) * 2.4f * radius;

        // Draw sphere
        pushMatrix();
        translate(x, -10, 0);
        rotateX(time * 0.3f);
        rotateY(time * 0.7f);
        rotateZ(time * 0.5f);
        scale(radius);
        drawGeosphere(i);
        popMatrix();

        // Draw label
        pushMatrix();
        translate(x, 30, 0);
        scale(0.25);
        text(String.valueOf(i), 0, 0);
        popMatrix();
    }
}

void drawGeosphere(int iterations) {
    // Regular tetrahedron, centered around the origin
    PVector a = new PVector(1, 1, 1).normalize();
    PVector b = new PVector(1, -1, -1).normalize();
    PVector c = new PVector(-1, 1, -1).normalize();
    PVector d = new PVector(-1, -1, 1).normalize();

    subDivide(a, b, c, iterations);
    subDivide(b, c, d, iterations);
    subDivide(c, d, a, iterations);
    subDivide(d, a, b, iterations);
}

void subDivide(PVector a, PVector b, PVector c, int iterations) {
    if (iterations <= 0) {
        line(a.x, a.y, a.z, b.x, b.y, b.z);
        line(b.x, b.y, b.z, c.x, c.y, c.z);
        line(c.x, c.y, c.z, a.x, a.y, a.z);
        return;
    }

    // Recurse
    PVector a2 = a.copy().add(b).mult(0.5f).normalize();
    PVector b2 = b.copy().add(c).mult(0.5f).normalize();
    PVector c2 = c.copy().add(a).mult(0.5f).normalize();

    subDivide(a, a2, c2, iterations - 1);
    subDivide(c, c2, b2, iterations - 1);
    subDivide(a2, b, b2, iterations - 1);
    subDivide(a2, b2, c2, iterations - 1);
}
