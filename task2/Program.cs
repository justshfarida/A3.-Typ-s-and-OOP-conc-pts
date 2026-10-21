using System;

class Employee
{
    public string Name;
    public double BaseSalary;

    public Employee(string name, double baseSalary)
    {
        Name = name;
        BaseSalary = baseSalary;
    }

    public virtual double CalculateSalary()
    {
        return BaseSalary;
    }

    public string GetRole()
    {
        return "Employee";
    }
}

class Manager : Employee
{
    public double Bonus;

    public Manager(string name, double baseSalary, double bonus)
        : base(name, baseSalary)
    {
        Bonus = bonus;
    }

    public override double CalculateSalary()
    {
        return BaseSalary+Bonus;
    }

    public new string GetRole()
    {
        return "Manager";
    }
}

class Program
{
    static void Main()
    {
        Employee e = new Employee("Aysel", 1000);
        Manager m = new Manager("Rashad", 1000, 500);
        Employee em = new Manager("Leyla", 1000, 500);  //the key case

        Console.WriteLine($"{e.Name}: {e.GetRole()}, salary {e.CalculateSalary()}");
        Console.WriteLine($"{m.Name}: {m.GetRole()}, salary {m.CalculateSalary()}");
        Console.WriteLine($"{em.Name}: {em.GetRole()}, salary {em.CalculateSalary()}");


    }
}