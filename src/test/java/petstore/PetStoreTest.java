package petstore;

import com.intuit.karate.junit5.Karate;

class PetStoreTest {
    @Karate.Test
    Karate testAll() {
        return Karate.run("petstore").relativeTo(getClass());
    }
}
