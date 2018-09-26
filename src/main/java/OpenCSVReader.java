import java.io.IOException;
import java.io.Reader;
import java.nio.file.Files;
import java.nio.file.Paths;

import com.opencsv.CSVReader;

public class OpenCSVReader {
	private static final String SAMPLE_CSV_FILE_PATH = "C:\\Users\\lestivalet\\Downloads\\AutoTextosDraRaquel_editado - Autotextos.csv";

	public static void main(String[] args) throws IOException {
		try (Reader reader = Files.newBufferedReader(Paths.get(SAMPLE_CSV_FILE_PATH));
				CSVReader csvReader = new CSVReader(reader);) {
			// Reading Records One by One in a String array
			String[] nextRecord;
			while ((nextRecord = csvReader.readNext()) != null) {

				String s = "| **Nome**| **Chave** | **Tipo** |\n";
				s += "| -------- | -------- | -------- |\n";
				s += "| <coluna=\"nome\">" + nextRecord[0] + "</coluna> | <coluna=\"chave\">" + nextRecord[2]
						+ "</coluna> ||\n";
				s += "\n\n";
				s += "|**Texto**  |\n";
				s += "|-------- |\n";
				s += "|<coluna=\"texto\">" + nextRecord[3] + "</coluna>|\n";
				s += "\n\n\n![image](/uploads/3f01a072d9f7fc363e9593f0a5c8c42a/image.png)\n\n";
				System.out.println(s);

				// System.out.println("Name : " + nextRecord[0]);
				// System.out.println("Email : " + nextRecord[1]);
				// System.out.println("Phone : " + nextRecord[2]);
				// System.out.println("Country : " + nextRecord[3]);
				// System.out.println("==========================");
			}
		}
	}
}
