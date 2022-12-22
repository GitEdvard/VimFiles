[Fact]
public void Test2()
{
    Person person = new Person();
    person.Register("edvard", "myaddress");
    Assert.Same(person.Name, "y");
}

