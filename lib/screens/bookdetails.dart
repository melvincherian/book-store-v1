import 'package:flutter/material.dart';

class BookDetails extends StatelessWidget {
  const BookDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 300,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/book3.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                  ),
                  child: const Text(
                    'Heart Of Darkness',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildDetailCard(
              label: 'Author Name:',
              value: 'Joseph Conrad',
            ),
            _buildDetailCard(
              label: 'About Book:',
              value:
                  'Heart of Darkness follows Charles Marlow\'s journey into the African Congo, where he encounters the brutal realities of European colonialism.',
            ),
            _buildDetailCard(
              label: 'Price:',
              value: 'RS200',
            ),
          
            _buildDetailCard(
              label: 'Publication Date:',
              value: 'January 1, 1899',
            ),
            _buildDetailCard(
              label: 'ISBN:',
              value: '978-1-56619-42d6-9',
            ),
            _buildDetailCard(
              label: 'Genre:',
              value: 'Fiction',
            ),
            _buildDetailCard(
              label: 'Format:',
              value: 'Paperback',
            ),
            _buildDetailCard(
              label: 'Page Count:',
              value: '160 pages',
            ),
            _buildDetailCard(
              label: 'Language:',
              value: 'English',
            ),
            _buildDetailCard(
              label: 'Awards:',
              value: 'Nobel Prize in Literature (Literature, 1924)',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard({required String label, required String value}) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
