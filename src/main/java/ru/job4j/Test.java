package ru.job4j;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Properties;

public class Test {
    private static final String SOURCE_LINK = "https://career.habr.com";
    private static final String PAGE_LINK = String.format("%s/vacancies/java_developer?page=", SOURCE_LINK);

    static Properties getProperties() {
        Properties properties = new Properties();
        try (InputStream in = Test.class.getClassLoader().getResourceAsStream("rabbit.properties")) {
            properties.load(in);
        } catch (Exception e) {
            throw new IllegalStateException(e);
        }
        return properties;
    }
    public static void main(String[] args) throws Exception {
        Properties pr = getProperties();
        HabrCareerDateTimeParser habrCareerDateTimeParser = new HabrCareerDateTimeParser();
        HabrCareerParse habrCareerParse = new HabrCareerParse(habrCareerDateTimeParser);

        String link = PAGE_LINK;
        List<Post> list = habrCareerParse.list(link);


        try (PsqlStore psqlStore = new PsqlStore(pr)) {

            for (Post post: list) {
                psqlStore.save(post);
            }
            List<Post> listPost = psqlStore.getAll();
            System.out.println("попали в ветку");
            System.out.println(listPost.get(0));
            Post post1 = psqlStore.findById(1);
            System.out.println(post1);
        }
        catch (IOException e) {
            System.out.println(e);
        }
    }
}
