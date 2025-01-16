//
// Algoritmos e Estruturas de Dados - 2024/2025
//
// J. Madeira - April/May 2022, December 2024
//
// COMPLETE the code, according to Circle.h
//

#include "Circle.h"

#define _USE_MATH_DEFINES

#include <cassert>
#include <cmath>
#include <iostream>
#include <string>

#include "Figure.h"
#include "Point.h"

Circle::Circle(void) : Figure(Point(0.0, 0.0), "black"), radius_(1.0) {
  // Circle of radius 1 and centered at (0,0)
}

Circle::Circle(Point center, const std::string& color, double length)
  : Figure(center,color) {
  // Ensure that the radius is larger than 0.0
  assert(length > 0);
  radius_ = length;
}

Circle::Circle(double x, double y, const std::string& color, double length)
  : Figure(Point(0, 0), color) {
  // Ensure that the radius is larger than 0.0
  assert(length > 0);
  radius_ = length;
}

double Circle::GetRadius(void) const { return radius_; }
void Circle::SetRadius(double length) {
  // Ensure that the radius is larger than 0.0
  // COMPLETE
}

std::string Circle::GetClassName(void) const { return "Circle"; }

double Circle::Area(void) const {
  // COMPLETE
  return M_PI * radius_ * radius_; 
}

double Circle::Perimeter(void) const {
  // COMPLETE
  return M_PI * radius_;
}

bool Circle::Intersects(const Circle& c) const {
  // dist(C1,C2) <= r1 + r2
  // if dist(C1,C2) == r1 + r2, then circles touch at a single point

  double distance_between_centers = GetCenter().DistanceTo(c.GetCenter());

  double sum_of_radii = radius_ + c.radius_;

  return (distance_between_centers < sum_of_radii);
}

std::ostream& operator<<(std::ostream& os, const Circle& obj) {
  os << "Center: " << obj.GetCenter() << std::endl;
  os << "Color: " << obj.GetColor() << std::endl; 
  os << "Radius = " << obj.radius_ << std::endl;
  return os;
}

std::istream& operator>>(std::istream& is, Circle& obj) {
  Point center;
  std::string color;
  double radius;

  std::cout << "Enter the center (x and y coordinates):\n";
  is >> center;
  std::cout << "Enter the color: ";
  is >> color;
  std::cout << "Enter the radius: ";
  is >> radius;

  assert(radius > 0.0); // Ensure radius is positive

  obj.SetCenter(center);
  obj.SetColor(color);
  obj.SetRadius(radius);

  return is;
}
