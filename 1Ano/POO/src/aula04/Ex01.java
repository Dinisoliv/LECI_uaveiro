package aula04;

import java.util.Arrays;
import java.util.Scanner;

public class Ex01 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int option;

        //System.out.print("Quantas formas quer criar: ");
        //int numberOfForms = sc.nextInt();
        //assert numberOfForms > 0;

        Circle[] circles = new Circle[10];
        Rectangle[] retangles = new Rectangle[10];
        Triangle[] triangles = new Triangle[10];

        int countCircles = 0;
        int countRetangle = 0;
        int countTriangle = 0;

        do {
            System.out.println("\nEscolha a forma geométrica a ser criada:");
            System.out.println("1. Círculo");
            System.out.println("2. Retângulo");
            System.out.println("3. Triângulo");
            System.out.println("4. List all forms created");
            System.out.println("0. Exit");
            
            option = sc.nextInt();

            switch (option) {
                case 1:
                    if (countCircles == 10) {
                        System.out.println("Limit of 10 triangles");
                        break;
                    }
                    System.out.println("xxx");
                    System.out.println("\nDigite o raio do circulo: ");
                    double radius = sc.nextDouble();
                    sc.nextLine();
                    System.out.println("Digite uma cor: ");
                    String colorCircle = sc.nextLine();
                    Circle circle = new Circle(radius, colorCircle);
                    System.out.println("Área do Circulo: " + circle.calculateArea());
                    System.out.println("Perímetro do Circulo: " + circle.calculatePerimeter());
                    System.out.println(circle.toString());
                    boolean novo = true;
                    for (int i = 0; i < countCircles; i++) {
                        if (circles[i] != null) {
                            if (circle.equals(circles[i])) {
                                System.out.println("Forma repetida");
                                novo = false;
                                break;
                            }
                        }
                    }
                    if (novo) {
                            circles[countCircles] = circle;
                            countCircles++;
                    }
                    break;
                case 2:
                    if (countRetangle == 10) {
                        System.out.println("Limit of 10 retangles");
                        break;
                    }
                    System.out.println("\nDigite altura do retângulo: ");
                    double height = sc.nextDouble();
                    System.out.println("Digite a largura do retângulo: ");
                    double lenght = sc.nextDouble();
                    sc.nextLine();
                    System.out.println("Digite uma cor: ");
                    String colorRetangle = sc.nextLine();
                    Rectangle retangle = new Rectangle(lenght, height, colorRetangle);
                    System.out.println("Área do Retângulo: " + retangle.calculateArea());
                    System.out.println("Perímetro do Retângulo: " + retangle.calculatePerimeter());
                    System.out.println(retangle.toString());
                    boolean flag = true;
                    for (int i = 0; i < countRetangle; i++) {
                        if (retangles[i] != null) {
                            if (retangle.equals(retangles[i])) {  //guardar os lados em array sorted e comparar (equals())
                                System.out.println("Forma repetida");
                                flag = false;
                                break;
                            }
                        }
                    }
                    if(flag){
                        retangles[countRetangle] = retangle;
                        countRetangle++;
                        break;
                    }
                    break;

                case 3:
                    if (countTriangle == 10) {
                        System.out.println("Limit of 10 triangles");
                        break;
                    }
                    System.out.println("\nDigite lado 1 do triângulo: ");
                    double side1 = sc.nextDouble();
                    System.out.println("Digite lado 2 do triângulo: ");
                    double side2 = sc.nextDouble();
                    System.out.println("Digite lado 3 do triângulo: ");
                    double side3 = sc.nextDouble();
                    sc.nextLine();
                    System.out.println("Digite uma cor: ");
                    String colorTriangle = sc.nextLine();
                    Triangle triangle = new Triangle(side1, side2, side3, colorTriangle);
                    System.out.println("Área do Triângulo: " + triangle.calculateArea());
                    System.out.println("Perímetro do Triângulo: " + triangle.calculatePerimeter());
                    System.out.println(triangle.toString());
                    boolean selc = true;
                    for (int i = 0; i < countTriangle; i++) {
                        if (triangles[i] != null) {
                            if (triangle.equals(triangles[i])) { //guardar os lados em array sorted e comparar (equals())
                                System.out.println("Forma repetida");
                                selc = false;
                                break;
                            }
                        }
                    }
                        if (selc) {
                            triangles[countTriangle] = triangle;
                            countTriangle++;
                            break;
                        }
                    break;
                case 4:
                    System.out.println(Arrays.toString(circles));
                    System.out.println(Arrays.toString(retangles));
                    System.out.println(Arrays.toString(triangles));

                    System.out.println("\nFormas registadas:");
                    System.out.println("Circulos:");
                    for (int i = 0; i <= countCircles; i++) {
                        if (circles[i] != null) {
                            System.out.println(circles[i].toString());   
                        }
                    }
                    System.out.println("Retângulos:");
                    for (int i = 0; i <= countRetangle; i++) {
                        if (retangles[i] != null) {
                            System.out.println(retangles[i].toString());
                        }
                    }
                    System.out.println("Triângulos:");
                    for (int i = 0; i <= countTriangle; i++) {
                        if (triangles[i] != null) {
                            System.out.println(triangles[i].toString());
                        }
                    }
                    break;
                default:
                    if (option != 0) {
                        System.out.println("Opção inválida");
                    }
            }
        } while (option != 0);
        System.out.println("Exiting...");
        sc.close();
        }
    }